import { app, BrowserWindow, Tray, Menu } from 'electron';
import path from 'path';

let browser: BrowserWindow | 0 = 0;
let tray: Tray | null = null;
let isQuiting : boolean = false;
let isVisible : boolean = false;

app.whenReady().then(() => {
    browser = new BrowserWindow({
        icon: 'assets/icon.ico',
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true,
            preload: path.join(__dirname, 'ai.js')
        }
    });

    browser.menuBarVisible = false;
    browser.loadFile('html/app.html');

    const trayIcon = path.join(__dirname, '../assets/icon.png');
    tray = new Tray(trayIcon);
    const contextMenu = Menu.buildFromTemplate([
        { label: 'Show / Quit', type: 'normal', click: () => {
            if (isVisible) {
                isVisible = false;
                app.hide();
            } else {
                isVisible = true;
                app.show();
            }
        } },
        { label: 'Quit', type: 'normal', click: () => { isQuiting = true; app.quit(); } }
    ]);
    tray.setContextMenu(contextMenu);
});

app.on('quit', (e) => {
    if (isQuiting) {
        e.preventDefault();
        app.quit();
        return
    }
    if (browser == 0) {
        return;
    }
    isVisible = false;
    browser.hide();
})