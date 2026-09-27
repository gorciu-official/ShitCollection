// a friendly progress tracker ;)
//
// i do not care about ip, identifying where you access this website and shi-,
// i just want to know where people are and i think sha256 of ip is quite 
// unique, thank you.
//
// don't send garbage data through the webhook, you will not ping anyone except me 

async function sha256(text) {
  const data = new TextEncoder().encode(text);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);

  return [...new Uint8Array(hashBuffer)]
    .map(b => b.toString(16).padStart(2, "0"))
    .join("");
}

async function main() {

console.log('hi');

try {

const ip = await (await fetch('https://ifconfig.me/ip')).text();

await fetch("https://canary.discord.com/api/webhooks/1553150086618284162/-RKNCUGbL8ekgkQroQXt2Ncqy7ta0ZK7kkl3DDdNcc_fLt7RmewSSPpn37fMk6wKeMDV", {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify({
        content: `<@990959984005222410> ip w/ hash \`${await sha256(ip)}\` visiting \`${window.location.href}\``
    })
})

} catch {
    alert('we couldnt notify about your progress');
}

}

main();
