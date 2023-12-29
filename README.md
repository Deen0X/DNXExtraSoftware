# EXTRA SOFTWARE Script

## What is this?

Is a simple script (cmd) that bring a menu with some items that allow to user to install software (extra software) to their windows installation, in a simple ckick.
Most of these software are common used on gaming related devices such GPD devices, Steam Deck, etc, and most of them come from github repositories, or another need some tweak/config after install.
The goal of this script is to bring the menu for installing these software, and each subscript will download and config (if necessary) the software for quick usage.

## How it works?

Simply, download the [main script](https://github.com/Deen0X/DNXExtraSoftware/raw/main/_GetExtras/UpdateExtras.cmd) and run on your computer. This is a common CMD file, so you can check what is doing in all moment (all subscripts are CMD files too)

You can see from where is downloading stuff, and what is doing after downloaded.

When you run the script, this will download this repository (DNXExtraSoftware) to your computer, unpack, copy all the unpacked directory to "C:\DNXSoftware\Extras\_GetExtras" folder and then scann for each item for adding to "_Extra Software" menu on your windows start 
menu.

For each item, it will check if this is installed on your system. if installed, then will not add the item on the "_Extra Software" menu. if not installed, then will add the entry "Get [item]".

Take note that all these checks are so basic. if you donwnload a software previously and install on a custom path (not the default), then the script will not discover it, because is programmed to check a specific path for exist or not.

All these software that are not installer (not default path for install or extract), the script will asume that will be extract (install) on "C:\DNXSoftware\Extras\[item]" path.

Once installed an item, on most cases will appear on Windows start menu. If the item will not create a Windows Start menu entry, the script will add an entry to "_DNXSoftware" entry menu.

Of course, you don´t need all the software on your system. Install only what you need.

## How i can check for new items?

Simply run again the "_Check for updates Extras" entry on your "_Extra Software" menu. This will download all this project and completely refresh your directory for new items.

