async function getSerchatToken() {
    if (localStorage && localStorage.getItem('serchat-auth-token'))
        return localStorage.getItem('serchat-auth-token');

    while (true) {
        const token = prompt('give serchat token like rn');

        if (!token) {
            alert('a custom client needs access to your token sorry. i won\'t steal your account so why even worry?');
            continue;
        }

        if (!Array.isArray(await apiRequest('servers', token))) {
            alert('THIS IS NOT A VALID TOKEN BROTHER! GIVE THE REAL ONE!');
            continue;
        }

        localStorage.setItem('serchat-auth-token', token);

        return token;
    }    
}

const SERCHAT_TOKEN = await getSerchatToken();

let ws: WebSocket | null = null;

interface BaseMessage {
    attachments: [],
    text: string,
    channelId: string,
    createdAt: string
}

interface WebhookMessage extends BaseMessage {
    webhookUsername: string,
    webhookAvatarUrl: string,
    isWebhook: true
}

interface UserMessage extends BaseMessage {
    isWebhook: false,
    senderId: string
}

type Message = UserMessage | WebhookMessage;

interface ServerMember {
    userId: string;
    user: {
        username: string;
        displayName: string | null;
        profilePicture: string;
    }
}

interface ServerCategory {
    name: string;
    id: string;
}

interface ServerChannel {
    id: string;
    categoryId: string;
    name: string;
    description: string;
    type: "link" | "text";
    link?: string;
}

const elements = {
    mainView: {
        typeArea: {
            textArea: document.querySelector('main .type-area textarea')! as HTMLTextAreaElement,
            sendButton: document.querySelector('main .type-area button')! as HTMLButtonElement
        }
    },
    channelView: {
        lowerHalf: {
            username: document.querySelector('.lower-half #user-name')! as HTMLSpanElement,
            displayName: document.querySelector('.lower-half #display-name')! as HTMLSpanElement,
        },
        upperHalf: {
            serverList: document.querySelector('.upper-half .server-list')! as HTMLDivElement
        }
    },
    errorArea: document.querySelector('.error-area')! as HTMLDivElement
};

function sortby<T extends Record<PropertyKey, any>>(arr: T[], key: string): T[] {
    return [...arr].sort((a, b) => a[key] - b[key]);
};

async function apiRequest(where: string, customToken: string | null = null) {
    console.log('requesting', where, customToken);

    return await (await fetch(`https://ser.chat/api/v1/${where}`, {
        headers: {
            "Authorization": "Bearer " + (customToken ?? SERCHAT_TOKEN)
        }
    })).json();
}

async function sendWs(type: string, payload: object) {
    if (ws?.readyState != WebSocket.OPEN) {
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve(sendWs(type, payload));
            }, 500);
        });
    }

    ws?.send(JSON.stringify({
        id: Date.now() + "-gorcius-client",
        event: { type, payload },
        meta: {
            ts: Date.now()
        }
    }));
}

async function getServerCategories(id: string): Promise<ServerCategory[]> {
    return await apiRequest(`servers/${id}/categories`);
}

async function activateServer(id: string) {
    // serchat knows everything
    sendWs('join_server', {
        serverId: id
    })

    const channels = sortby(await apiRequest('servers/' + id + '/channels'), "position") as ServerChannel[];
    const categories = await getServerCategories(id);
    const list = document.querySelector('.channel-list')!;
    list.innerHTML = '';

    let currentCategoryId = null;

    for (const channel of channels) {
        if (currentCategoryId != channel.categoryId) {
            currentCategoryId = channel.categoryId;

            const cat = categories.find((c => c.id == channel.categoryId));

            const catel = document.createElement('p');
            catel.textContent =
                cat
                    ? cat.name
                    : 'category id ' + channel.categoryId;
            catel.classList.add('category-name');
            list.appendChild(catel);
        }

        const chel = document.createElement('p');
        chel.textContent = channel.name;
        chel.classList.add('channel-entry');
        chel.addEventListener('click', async () => {
            if (channel.type == "link") {
                return window.open(channel.link);
            }
            
            sendWs('join_channel', {
                serverId: id,
                channelId: channel.id
            })

            const messages = await apiRequest(`servers/${id}/channels/${channel.id}/messages?limit=50`);
            displayMessages(messages, id, channel);
        })
        list.appendChild(chel);
    }
}

let current_data: { sid: string | null, channel: ServerChannel | null } = { sid: null, channel: null };

async function displayMessages(msgs: Message[], sid: string, channel: ServerChannel) {
    const members = await apiRequest(`servers/${sid}/members`) as ServerMember[];
    const msgarea = document.querySelector('main .msg-area')!;
    msgarea.parentElement!.classList.remove('hidden');
    msgarea.parentElement!.querySelector('#channel-name')!.textContent = channel.name;
    msgarea.parentElement!.querySelector('#channel-desc')!.textContent = channel.description ?? 'Looks like this channel does not have a description, tell the server owner to create one!';
    elements.mainView.typeArea.textArea.dataset['sid'] = sid;
    elements.mainView.typeArea.textArea.dataset['cid'] = channel.id;
    current_data.channel = channel;
    current_data.sid = sid;
    for (const message of msgs) {
        const member = 
            message.isWebhook 
                ? undefined 
                : members.find((m) => m.userId == message.senderId);

        const msgel = document.createElement('div');
        const msgauthor = document.createElement('p');
        msgauthor.textContent =
            member?.user.displayName ??
            member?.user.username ??
            (message.isWebhook ? message.webhookUsername : undefined) ??
            'Unknown user';
        const msgtext = document.createElement('p');
        msgtext.classList.add('message-text');
        msgtext.textContent = message.text;
        msgel.appendChild(msgauthor);
        msgel.appendChild(msgtext);

        const msgwrapper = document.createElement('div');
        msgwrapper.classList.add('message');
        const user_picture = document.createElement('img');
        user_picture.src =
            member?.user.profilePicture
                ? `https://ser.chat${member.user.profilePicture}`
                : (message.isWebhook ? message.webhookAvatarUrl : '/app/abstract-user-flat-3.png');
        user_picture.classList.add('message-pfp');
        const upw = document.createElement('div');
        upw.appendChild(user_picture);
        msgwrapper.appendChild(upw);
        msgwrapper.appendChild(msgel);
        msgarea.appendChild(msgwrapper);
    }
}

async function setSerchatServers() {
    /** @type {{icon: string;id:string;}[]} */
    const servers = await apiRequest('servers');
    const list = elements.channelView.upperHalf.serverList;

    let firstserverid = null;

    for (const server of servers) {
        if (!firstserverid)
            firstserverid = server.id;

        const iconExists = !!server.icon;

        const entry = document.createElement(iconExists ? 'img' : 'p');
        if (iconExists)
            (entry as HTMLImageElement).src = "https://ser.chat" + server.icon;
        else
            entry.textContent = server.name.at(0).toUpperCase();
        entry.classList.add("server-entry");
        entry.dataset.serverid = server.id;
        entry.addEventListener('click', () => {
            activateServer(server.id);
        })
        list.appendChild(entry);
    }

    activateServer(firstserverid);
}

async function error(reason: string) {
    const errbox = document.createElement('div');
    errbox.classList.add('error-box');
    errbox.textContent = reason;

    setTimeout(() => {
        errbox.remove();
    }, 5000);

    elements.errorArea.appendChild(errbox);
}

async function main() {
    ws = new WebSocket(`wss://ser.chat/ws`);
    ws.onmessage = async (message) => {
        const msg = JSON.parse(message.data);
        if (msg?.event?.type !== 'pong') console.log(msg);

        switch (msg.event.type) {
            case 'authenticated': {
                elements.channelView.lowerHalf.displayName.textContent = msg.event.payload.user.displayName;
                elements.channelView.lowerHalf.username.textContent = msg.event.payload.user.username;
                setInterval(async () => {
                    await sendWs('ping', {});
                }, 5000);
                await setSerchatServers();
                elements.mainView.typeArea.sendButton.addEventListener('click', (e) => {
                    const textarea = elements.mainView.typeArea.textArea;
                    sendWs('send_message_server', {
                        serverId: textarea.dataset['sid'],
                        channelId: textarea.dataset['cid'],
                        attachments: [],
                        text: textarea.value
                    });
                    textarea.value = '';
                })
                break;
            }
            case 'error': {
                function getErrorReason(): string {
                    if (Array.isArray(msg.event.payload.details)) {
                        return msg.event.payload.details.join('\n');
                    }
                    return msg.event.payload.details?.message ?? msg.event.payload.message ?? msg.event.payload.code;
                }
                error(getErrorReason());
                break;
            }
            case 'message_server': {
                displayMessages([msg.event.payload], current_data.sid!, current_data.channel!);
                break;
            }
            default:
                break;
        }
    }
    ws.onclose = (ev) => {
        window.location.reload();
    }
    ws.onopen = async () => {
        await sendWs('authenticate', {
            token: SERCHAT_TOKEN
        });
    }
}

main();

export {};