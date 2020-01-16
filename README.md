# Misc

To copy all the contend of this Misc repository to the downloads folder of Raspi:

    sudo git clone https://github.com/JamFfm/Misc.git --single-branch /home/pi/Downloads/Misc
    
## Install.sh

This file is modified so i can install some helpful tools in an easy way.
Helpful if you reinstall CBPi.
To manually open the installer file use:

    sudo ./install.sh

## los.sh

I used this file in home/pi/.
In a commandbox key in ./los.sh and the installer will open.

No need to change directory or sudo

## CraftBeerPi.desktop

Use an icon on the desktop to start installer.
This replaces the los.sh usage.

This file can be copied to the desktop by the installer. Hense every country has got different foldername for Desktop the script of the installer will only function in germany.

You can create a new file on the desktop with right click. Name the file *CraftBeerPi.desktop*.
Copy the contend of the file in this repository to the new created one.
Save and you will have a nice CBPi icon on the desktop.

## core.py

Replace the core.py file with this file. No more problems with the tempgraphs.
This is made by Carlallen

https://github.com/Manuel83/craftbeerpi3/pull/84?fbclid=IwAR2qc6S3yJuj3ILhWCJ8Zzqai-JX5Lkqc6CcQPzTnunbff9SIsD95ARGNVw

## init.py.mqtt

This file should replace the orign file in the mqtt addon if you **want to use mqtt via sonoff with tasmota firmware**. Only the jason string to detect the status is changed.

You need to install paho-mqtt and mosquitto to use the mqtt addon in general. You can do this by the install script or use this:

    sudo apt-get update
    sudo pip install paho-mqtt
    sudo apt-get install mosquitto

Use the file without x.mqtt ending in the path of the mqtt addon.

## cbpi-BetterChart

Add a new chart engine to cbpi

    git clone https://github.com/MiracelVip/cbpi-BetterChart /home/pi/craftbeerpi3/modules/plugins/cbpi-BetterChart

## sql light browser

Install it via install script or use:

    sudo apt-get update
    sudo apt-get install sqlitebrowser

## bootstrap.dark.css

install patch for proprer window boarders:

    sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/bootstrap.dark.css
    or
    Start nano editor: "sudo nano craftbeerpi3/modules/ui/static/bootstrap.dark.css"
    Ctrl-w -> search for "container-fluid"
    Scroll a bit to the right until you find"{margin-left:-15px;margin-right:-15px}"
    change to {margin-left:-15px;margin-right:-5px}
    Ctrl-x to save/close
    reboot
    Remember to clear cache in browser

Have fun brewing!!

