# EXTRA SOFTWARE Script

![image](https://github.com/Deen0X/DNXExtraSoftware/assets/3720302/6635f8c7-92e2-44d6-8e3d-cd9f63f10cb4)

## What is this?

Is a simple script (cmd) that bring a menu with some items that allow to user to install software (extra software) to their windows installation, in a simple ckick.
Most of these software are common used on gaming related devices such GPD devices, Steam Deck, etc, and most of them come from github repositories, or another need some tweak/config after install.
The goal of this script is to bring the menu for installing these software, and each subscript will download and config (if necessary) the software for quick usage.

## How it works? 

Simply, download the [main script](https://github.com/Deen0X/DNXExtraSoftware/raw/main/_GetExtras/UpdateExtras.cmd) (Right click and save as) and run on your computer. This is a common CMD file, so you can check what is doing in all moment (all subscripts are CMD files too)

You can see from where is downloading stuff, and what is doing after downloaded.

When you run the script, this will download this repository (DNXExtraSoftware) to your computer, unpack, copy all the unpacked directory to "C:\DNXSoftware\Extras\_GetExtras" folder and then scann for each item for adding to "_Extra Software" menu on your windows start 
menu.

For each item, it will check if this is installed on your system. if installed, then will not add the item on the "_Extra Software" menu. if not installed, then will add the entry "Get [item]".

As example, here are some items for install on the menu

![image](https://github.com/Deen0X/DNXExtraSoftware/assets/3720302/807aaf74-406d-4b37-9604-73fd46a19082)

and here is once Borderless Gaming was installed on the system

![image](https://github.com/Deen0X/DNXExtraSoftware/assets/3720302/3e81aa13-dd79-4814-aecb-64f4c1158d36)

As you can see the item "Get Borderless Gaming" dissapear from the menu.

Take note that all these checks are so basic. if you donwnload a software previously and install on a custom path (not the default), then the script will not discover it, because is programmed to check a specific path for exist or not.

All these software that are not installer (not default path for install or extract), the script will asume that will be extract (install) on "C:\DNXSoftware\Extras\[item]" path.

Once installed an item, on most cases will appear on Windows start menu. If the item will not create a Windows Start menu entry, the script will add an entry to "_DNXSoftware" entry menu.

Of course, you don´t need all the software on your system. Install only what you need.

## How i can check for new items?

Simply run again the "_Check for updates Extras" entry on your "_Extra Software" menu. This will download all this project and completely refresh your directory for new items.

![image](https://github.com/Deen0X/DNXExtraSoftware/assets/3720302/389ba847-ae8a-44b8-8feb-dce4336bb163)

## when this will be updated?

I will check for useful programs that maybe on this list. At first glance i don´t want to full this list of many programs. I want to add only things that i consider useful.

I'm open to suggestions for adding new entries on this. You can comment on 


## Ok. but which software are included for install?

Well, you can check the ["_GetExtras"](https://github.com/Deen0X/DNXExtraSoftware/tree/main/_GetExtras) folder and check it. Each subfolder = Item.

Currently, there is a quick list of items included.

- AllInOne Runtimes. A collection of DLLs, Frameworks, DirectX, components, etc for run software and games on windows.
- AutoWall Live Wallpaper - A simple a lighweight program for Live Wallpapers
- BOBWin Lite - A Lite version from BOBWin project, a Multi-Emulator platform.
- Borderless Gaming - A Windows program that enable Fullscreen for Windowed applications.
- Chiaki Playstation Streaming - An open source solution for streaming from PS4/PS5 to Windows.
- Chiaki4Deck Playstation Streaming - The same as Chiaki but more updated and with optimizations for Steam Deck.
- Chocolatey - This is a command line based store.
- Controller Companion - Mainly used with old devices such GPD-WIN1/WIN2, for adding functionallity on desktop for gamepad, or remap controls.
- GameSave Manager - Alternative for cloud based savegames outside of official launchers.
- Gamestreaming Moonlight - Client for streaming for (original GeForce Experience) Sunshine Server
- Gamestreaming Sunshine Server - Server part for streaming to Moonlight
- Group Policy Editor - This enable Group Policy Editor on Windows Home editions
- Handheld Companion - Software for some gaming devices that bring functionallity for gamepads. This will download a preconfigured setup.
- Magpie Scaling Tool - All purpose window upsacler for Windows 10/11
- Motion Assistant - Software for control TDP (auto), Gyro assign, etc. This runs most on GPD devices.
- Snappy Driver Installer - Check for devices and offers updated drivers.
- Steam Link - Streaming client for Steam. (Remote control)
- Winaero Tweaker - Tweaks many aspects on windows. This can enable or disable some features such Microsoft Defender, etc.
- Windows Subsystem for Android - Allow to run Android apps as native apps on windows 10/11
