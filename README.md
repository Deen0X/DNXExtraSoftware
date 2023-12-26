# DNXWIN
DNXWIN Project Related

## What is DNXWIN Project?
At first instance, i want to create my own version of "Windows Lite/tiny/etc" for use with my gaming devices (GPD WIN, WIN2, WIN3, WIN4, WINMAX, WINMAX2, Steam Deck, etc) that bring me the experience of windows, but without "extra" stuff that i don´t need.
After creating this windows, and testing it, i finally get the conclussion that this is not really what i want on my machines, or at least, not on all my devices.
There are some of them that are low on resources and they need a special windows with minimal services, etc, for bring resources to games. this may be the case of GPD-WIN and GPD-WIN2, but since GPD-WIN3/WINMAX there are enough resources for running games without the need of short services/programs on windows (because these programs or services really will not affect on general performance on gaming, so i decided to get another point of view about the way to install and use windows (and create an iso or it), so i point to optimize windows instead of eliminating services from the oiginal ISO.
With this in mind, i created a "BASE" Windows ISO, where i did "light" tweaks on it. These tweaks are based on my project DNXDOSScript, where i divided these tweaks into two parts.
1- Regitry tweaks focussed on gain performance on a Windows installation.
2- Script that do more in-deep modifications on windows, disabling or deleting some components, etc.

So, on the main Windows ISO "BASE", i only applied the Registry level tweaks
After this, i included some basic software that i consider essential in any windows installation, and this is the list of some of these software:
- Autowall +1 -> A small and light software for bring live wallpapers on windows.
- Common Runtimes and frameworks, such VC, .NET, etc.
- 7-Zip -> For general compressed file management.
- Notepad++ -> essential tool
- Google Chrome -> I think is the best choice, but if the user don´t want, simply can uninstall from control panel.
- Steam +2 -> Most popular launcher.
- WizTree -> A small and quick tool for grahpical check disk usage

+1 Really is not an essential software, but i like the impact of the iso on their first boot and see an animated wallpaper on the desktop. Of course this program can be stoped or removed if don´t like to the final user.
+2 I decided to include Steam because is the most popular library/launcher, and because the program update itself on each launch, so there is no problem really using an "old" version (in case the user is installing this iso on future), because steam always will be up to date.

There maybe other small programs included on the iso that i will try to keep this list up to date.

With the previous configuration of essential software, light tweaked iso and optimization (using the reg) i generated a BASE ISO for the main project. This ISO can be used on any computer for installing windows, but user will need to install their own drivers.
This BASE Project is called DNXWIN10 and come in two versions: PRO and HOME

## Why generating two version?
Simple. Most windows gaming devices such GPD devices, AYA, etc, come with HOME version from factory. This is related to Windows licences with manufacturers, and for this reason most of them uses this kind of licences. So, for these devices that come with a OEM licence activated on their devices, so for this reason i process a HOME version for allow users to keep their licence on the new windows.
After some requests i decided to process a PRO version for machines that don´t come with windows, such Steam Deck, so users can activate it with their own PRO licence on the device.
Essentially both windows come with the same software and pre-configured stuff. Simply windows PRO may bring few features that Home don´t have (Remote Desktop Protocol RDP, but there are a lot of alternatives such Chrome Remote Desktop. Group Policy Editor GPEDIT, but you can get an alternative for Windows Home included on Extra Software menu, included too on the ISO)

## EDITIONS

### Current BASE edition (GEN) version is 2.1

DNXWIN10_22H2_HOM_GEN_2.1 - Windows 10 22H2 Home edition
DNXWIN10_22H2_PRO_GEN_2.1 - Windows 10 22H2 Pro edition

### GPD-WIN3 Edition

This edition come with all drivers out of the box, and included some preconfigured software:

- Motion Assistant
- Handheld Companion


