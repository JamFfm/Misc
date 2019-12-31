# Misc

to copy all the contend to downloads folder of Raspi:

    sudo git clone https://github.com/JamFfm/Misc.git --single-branch /home/pi/Downloads/Misc
    
## Install.sh

this file is midified so i con install some helpfull tools in an easy way.
Helpful if you reinstall CBPi

## los.sh

i used this file in home/pi/.
In a commandbox key in ./los.sh and the installer will open.

No need to change directory or sudo

## CraftBeerPi.desktop

Use an icon on the desktop to start installer.

This file can be copied to the desktop. Hense every country has got different foldername für Desktop the script of the installer will only function in germany.

You can create a new file on the desktop with right click. Name the file *CraftBeerPi.desktop*.
Copy the contend of the filein this repository to the new created one.

## core.py

replace the core.py file with tis file. No more problems with the tempgraphs.
<this is made by Carlallen

## init.py.mqtt

this file should replace the orign file in the mqtt addon if you want to use sonoff with tasmota firmware. Only the jason string to detect the status is changed.

you need to install paho-mqtt and mosquitto to use the mqtt addon. ou cayn do this by the install script or use this:

    sudo apt-get update
    sudo pip install paho-mqtt
    sudo apt-get install mosquitto

Use ist without x.mqtt ending

## cbpi-BetterChart

Add a new chart engine to cbpi

    git clone https://github.com/MiracelVip/cbpi-BetterChart /home/pi/craftbeerpi3/modules/plugins/cbpi-BetterChart

## sql light browser

install it via installscript or

    sudo apt-get update
    sudo apt-get install sqlitebrowser



