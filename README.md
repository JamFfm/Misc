# Misc

This is my collection of CBPi3 "Patches" and helpful gadgets.

They all can be installes via install.sh
In this read me I just explaine what and how the scripts innstall.


To copy all the contend of this Misc repository to the downloads folder of Raspi:

    sudo git clone https://github.com/JamFfm/Misc.git --single-branch /home/pi/Downloads/Misc
    
## Install.sh

This file is modified so i can install some helpful tools in an easy way.
Helpful if you reinstall CBPi.
To manually run the installer file copy it to the folder /home/pi/craftbeerpi3 and key in:

    cd /home/pi/craftbeerpi3
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

*sonoff

This file should replace the orign file in the mqtt addon if you **want to use mqtt via sonoff with tasmota firmware**. Only the jason string to detect the status is changed.

You need to install paho-mqtt and mosquitto to use the mqtt addon in general. You can do this by the install script or use this:

    sudo apt-get update
    sudo pip install paho-mqtt
    sudo apt-get install mosquitto

Use the file without x.mqtt ending in the path of the mqtt addon.

Here you can see the paraemeter of the mqtt Sensor addon in use of a sonoffTH16:


![Screens](https://github.com/JamFfm/Misc/blob/master/sonoffMqttParameterInCBPI3.jpg "Parameter of Mqtt Plugin")
![Screens](https://github.com/JamFfm/Misc/blob/master/sonoffMqttParameterInCBPI3Actor.jpg "Parameter of Mqtt Plugin")


## ESPEasy config for generic http: ##

Use this link for the picture how to set parameter on the ESPEasy side.

https://www.facebook.com/photo.php?fbid=534968119609&set=pcb.1724788664490943&type=3&ifg=1

This is the CBPi 3 side of the http actor addon:

![Screens](https://github.com/JamFfm/Misc/blob/master/Http_Actor.PNG "Parameter of http Plugin")


## cbpi-BetterChart

Add a new chart engine to cbpi. But first you have to install the CBPi addon "ExtendedMenue"

    git clone https://github.com/MiracelVip/cbpi-BetterChart /home/pi/craftbeerpi3/modules/plugins/cbpi-BetterChart

## sql light browser

Install it via install script or use:

    sudo apt-get update
    sudo apt-get install sqlitebrowser

## bootstrap.dark.css

install patch for proprer window boarders:

    sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/bootstrap.dark.css
    
 or do it manually:
    
 Start nano editor: "sudo nano craftbeerpi3/modules/ui/static/bootstrap.dark.css"
 Ctrl-w -> search for "container-fluid"
 Scroll a bit to the right until you find"{margin-left:-15px;margin-right:-15px}"
 change to {margin-left:-15px;margin-right:-5px}
    
 Ctrl-x to save/close
    
 reboot
    
 Remember to clear cache in browser
    
## add an CBPi icon on ios gadgets while storing link to CBpi ##

This downloads the index.html file from Misc to /home/pi/craftbeerpi3/modules/ui/static/index.html.

There are two lines added in the index html file:

     <head> 
        
        <meta charset="utf-8"> 
        
        <meta name="viewport" content="width=device-width, initial-scale=1"> 

        <meta name="apple-mobile-web-app-capable" content="yes" />          -->new 
        <link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico">         
        <link rel="stylesheet" href="static/bootstrap.min.css"> 
        <link rel="stylesheet" href="static/css/font-awesome.min.css"> 
        <link rel="stylesheet" href="static/bootstrap.dark.css"> 
        <link rel="apple-touch-icon" href="/ui/static/logo.png" />          -->new
        <title>CraftBeerPi 3.0</title> 
      </head> 
      <body>
      ......

## add sound to the browser -this is cool- ##

To add sound to the browser, do the following:

open the file home /pi/craftbeerpi3/modules/ui/static/bundle.js 

Add the code after the fragment "var e=this.props.messages;":

var audioAlert = new Audio ("static/beep.wav");

audioAlert.play();

it looks like: 

    .....var e=this.props.messages;var audioAlert=new Audio ("static/beep.wav");audioAlert.play();return d.default.createElem.....

And put any wav file in the folder home/pi/craftbeerpi3/modules/ui/static/ called beep.wav "


Have fun brewing!!
