#!/bin/bash
# CraftBeerPi Installer
# Copy 2017 Manuel Fritsch

confirmAnswer () {
whiptail --title "Confirmation" --yes-button "Yes" --no-button "No"  --defaultno --yesno "$1" 10 56
return $?
}

show_menu () {
   # We show the host name right in the menu title so we know which Pi we are connected to
   ipaddr="$(sudo ip addr show dev "$(ip route ls|awk '/default/ {print $5}')"|grep -Po 'inet \K(\d{1,3}\.?){4}')"
   OPTION=$(whiptail --title "CraftBeerPi 3.0.2           $ipaddr" --menu "Choose your option:" 20 70 14 \
   "1" "Install CraftBeerPi" \
   "2" "Clear Database" \
   "3" "Add To Autostart" \
   "4" "Remove From Autostart" \
   "5" "Start CraftBeerPi" \
   "6" "Stop CraftBeerPi" \
   "7" "Software Update (git pull)" \
   "8" "Reset File Changes (git reset --hard)" \
   "9" "Clear all logs" \
   "10" "Reboot Raspberry Pi" \
   "11" "Install SQL Light Client" \
   "12" "Install Mqtt lib" \
   "13" "Install Mqtt broker" \
   "14" "Clone all files from git Misc in Downloads" \
   "15" "Install TFTDisplay libs" \
   "16" "Install Alexa libs. Notice Readme of addon" \
   "17" "Install rrdTool" \
   "18" "Detect I2C address (ex.for LCDDisplay plugin)" \
   "19" "Install MCP3008 to read analog devices" \
   "20" "Install betterCharts Plugin" \
   "21" "Install CBPi desktop icon" \
   "22" "Install patch for proper window borders" \
   "23" "Install patch for use sonoff with mqtt" \
   "24" "Add metatag to enable ""Add to home"" screen on IOS devices #230" \
   "25" "Add sound massages to the browser" \
   "26" "Add eManometer addin"\
   "27" "Stop-del all Logfiles-Start"  3>&1 1>&2 2>&3)

   BUTTON=$?
   # Exit if user pressed cancel or escape
   if [[ ($BUTTON -eq 1) || ($BUTTON -eq 255) ]]; then
       exit 1
   fi
   if [ $BUTTON -eq 0 ]; then
       case $OPTION in
       1)
           confirmAnswer "Would you like run apt-get update & apt-get upgrade?"
           if [ $? = 0 ]; then
             apt-get -y update; apt-get -y upgrade;
           fi

           apt-get -y install python-setuptools
           easy_install pip
           apt-get -y install python-dev
           apt-get -y install libpcre3-dev
           pip install -r requirements.txt

           confirmAnswer "Would you like to add active 1-wire support at your Raspberry PI now? IMPORTANT: The 1-wire thermometer must be conneted to GPIO 4!"
           if [ $? = 0 ]; then
             #apt-get -y update; apt-get -y upgrade;
             echo '# CraftBeerPi 1-wire support' >> "/boot/config.txt"
             echo 'dtoverlay=w1-gpio,gpiopin=4,pullup=on' >> "/boot/config.txt"

           fi

           sudo mv ./config/splash.png /usr/share/plymouth/themes/pix/splash.png

           sed "s@#DIR#@${PWD}@g" config/craftbeerpiboot > /etc/init.d/craftbeerpiboot
           chmod 755 /etc/init.d/craftbeerpiboot;

           whiptail --title "Installition Finished" --msgbox "CraftBeerPi installation finished! You must hit OK to continue." 8 78
           show_menu
           ;;
       2)
           confirmAnswer "Are you sure you want to clear the CraftBeerPi. All hardware setting will be deleted"
           if [ $? = 0 ]; then
             sudo rm -f craftbeerpi.db
             whiptail --title "Database Delted" --msgbox "The CraftBeerPi database was succesfully deleted. You must hit OK to continue." 8 78
             show_menu
           else
             show_menu
           fi
           ;;
       3)
           confirmAnswer "Are you sure you want to add CraftBeerPi to autostart"
           if [ $? = 0 ]; then
             sed "s@#DIR#@${PWD}@g" config/craftbeerpiboot > /etc/init.d/craftbeerpiboot
             chmod 755 /etc/init.d/craftbeerpiboot;
             update-rc.d craftbeerpiboot defaults;
             whiptail --title "Added succesfull to autostart" --msgbox "The CraftBeerPi was added to autostart succesfully. You must hit OK to continue." 8 78
             show_menu
           else
             show_menu
           fi
           ;;
       4)
           confirmAnswer "Are you sure you want to remove CraftBeerPi from autostart"
           if [ $? = 0 ]; then
               update-rc.d -f craftbeerpiboot remove
               show_menu
           else
               show_menu
           fi
           ;;
       5)
           sudo /etc/init.d/craftbeerpiboot start
           ipaddr="$(sudo ip addr show dev "$(ip route ls|awk '/default/ {print $5}')"|grep -Po 'inet \K(\d{1,3}\.?){4}')"
           whiptail --title "CraftBeerPi started" --msgbox "Please connect via Browser: http://$ipaddr:5000" 8 78
           show_menu
           ;;
       6)
           sudo /etc/init.d/craftbeerpiboot stop
           whiptail --title "CraftBeerPi stoped" --msgbox "The software is stoped" 8 78
           show_menu
            ;;
       7)
           confirmAnswer "Are you sure you want to pull a software update?"
           if [ $? = 0 ]; then
             whiptail --textbox /dev/stdin 20 50 <<<"$(git pull)"
              show_menu
           else
              show_menu
           fi
           ;;
       8)
           confirmAnswer "Are you sure you want to reset all file changes for this git respository (git reset --hard)?"
           if [ $? = 0 ]; then
             whiptail --textbox /dev/stdin 20 50 <<<"$(git reset --hard)"
             show_menu
           else
             show_menu
           fi
            ;;
       9)
           confirmAnswer "Are you sure you want to delete all CraftBeerPi log files"
           if [ $? = 0 ]; then
             sudo rm -rf logs/*.log
             whiptail --title "Log files deleted" --msgbox "All CraftBeerPi Files are deleted. You must hit OK to continue." 8 78
             show_menu
           else
             show_menu
           fi
           ;;
       10)
           confirmAnswer "Are you sure you want to reboot the Raspberry Pi?"
           if [ $? = 0 ]; then
             sudo reboot
           else
             show_menu
           fi
           ;;
       11)
           confirmAnswer "Are you sure to install sqlitebrowser?"
           if [ $? = 0 ]; then
             sudo apt-get update
             sudo apt-get install sqlitebrowser
             show_menu
           else
             show_menu
           fi
           ;;
       12)
           confirmAnswer "Are you sure to install python MQTT lib paho? Please use this only when you want to use Mqtt protokoll!"
           if [ $? = 0 ]; then
             sudo pip install paho-mqtt
             show_menu
           else
             show_menu
           fi
           ;;
       13)
           confirmAnswer "Are you sure to install MQTT Broker mosquitto? Please use this only when you want to use Mqtt protokoll!"
           if [ $? = 0 ]; then
             sudo apt-get update
             sudo apt-get install mosquitto
             show_menu
           else
             show_menu
           fi
           ;;
       14)
           confirmAnswer "Are you sure to clone all files from Git JamFfm Misc to Downloads?"
           if [ $? = 0 ]; then
             sudo git clone https://github.com/JamFfm/Misc.git --single-branch /home/pi/Downloads/Misc
             show_menu
           else
             show_menu
           fi
           ;;
       15)
      	   confirmAnswer "Are you sure install Adafruit_Pyton_ILI9341 for TFTDisplay?"
      	   if [ $? = 0 ]; then
      	     sudo apt-get install build-essential python-dev python-smbus python-pip python-imaging python-numpy git
      	     sudo pip install pathlib
      	     sudo pip install RPi.GPIO
      	     sudo git clone https://github.com/adafruit/Adafruit_Python_ILI9341.git
      	     cd Adafruit_Python_ILI9341 || exit
      	     sudo python setup.py install
      	     sudo chown -R pi /home/pi/craftbeerpi3/Adafruit_Python_ILI9341
             show_menu
           else
             show_menu
           fi
           ;;
       16)
      	   confirmAnswer "Are you sure to install flask-ask libs for Alexa-Plugin?"
      	   if [ $? = 0 ]; then
      	     sudo pip install flask-ask
             show_menu
           else
             show_menu
           fi
           ;;
	     17)
	         confirmAnswer "Please install rrdTool for TFTDisplay addon from Raspi GUI!"
	         if [ $? = 0 ]; then
             show_menu
           else
             show_menu
           fi
           ;;
       18)
           confirmAnswer "Are you sure to detect the I2C address? There is an error because usually only one of 2 ports is available"
           if [ $? = 0 ]; then
             sudo i2cdetect -y 1
             sudo i2cdetect -y 0
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       19)
           confirmAnswer "Are you sure to install Adafruit_Python_MCP3008?"
           if [ $? = 0 ]; then
             sudo apt-get update
             sudo apt-get install build-essential python-dev python-smbus git
             cd /home/pi/craftbeerpi3 || exit
             git clone https://github.com/adafruit/Adafruit_Python_MCP3008.git
             cd Adafruit_Python_MCP3008 || exit
             sudo python setup.py install
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       20)
           confirmAnswer "Are you sure to install BetterCharts? Currently in in beta Mode! Please install addon ExtendedMenu first"
           if [ $? = 0 ]; then
             git clone https://github.com/MiracelVip/cbpi-BetterChart /home/pi/craftbeerpi3/modules/plugins/cbpi-BetterChart
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       21)
           confirmAnswer "Install CBPi desktop icon?"
           if [ $? = 0 ]; then
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/CraftBeerPi.desktop
             sudo mv CraftBeerPi.desktop /home/pi/Schreibtisch
             sudo chmod a+rwx /home/pi/Schreibtisch/CraftBeerPi.desktop
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       22)
           confirmAnswer "Install border update (proper distance at the boarders of window)?"
           if [ $? = 0 ]; then
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/bootstrap.dark.css
             sudo mv -b bootstrap.dark.css /home/pi/craftbeerpi3/modules/ui/static
             sudo chmod a+rwx /home/pi/craftbeerpi3/modules/ui/static/bootstrap.dark.css
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       23)
           confirmAnswer "Install patch for use mqtt of a sonoff TH16 with DS18B20 and tasmota firmware. First install mqtt addon from CBPI!"
           if [ $? = 0 ]; then
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/__init__.py.mqtt
             sudo mv -b __init__.py.mqtt /home/pi/craftbeerpi3/modules/plugins/MQTTPlugin/__init__.py
             sudo chmod a+rwx /home/pi/craftbeerpi3/modules/plugins/MQTTPlugin/__init__.py
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       24)
           confirmAnswer "add metatag to enable <Add to home> screen on IOS devices. #230"
           if [ $? = 0 ]; then
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/index.html
             sudo mv -b index.html /home/pi/craftbeerpi3/modules/ui/static/index.html
             sudo chmod a+rwx /home/pi/craftbeerpi3/modules/ui/static/index.html
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       25)
           confirmAnswer "add sound massages to the browser #215"
           if [ $? = 0 ]; then
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/bundle.neu.js
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/beep.wav
             sudo mv -b bundle.neu.js /home/pi/craftbeerpi3/modules/ui/static/bundle.js
             sudo mv beep.wav /home/pi/craftbeerpi3/modules/ui/static/beep.wav
             sudo chmod a+rwx /home/pi/craftbeerpi3/modules/ui/static/bundle.js
             sudo chmod a+rwx /home/pi/craftbeerpi3/modules/ui/static/beep.wav
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       26)
           confirmAnswer "Add eManometer addon"
           if [ $? = 0 ]; then
             sudo mkdir /home/pi/craftbeerpi3/modules/plugins/eManometer
             sudo wget https://raw.githubusercontent.com/JamFfm/Misc/master/eManometer/__init__.py.eManometer
             sudo mv -b __init__.py.eManometer /home/pi/craftbeerpi3/modules/plugins/eManometer/__init__.py
             sudo chmod a+rwx /home/pi/craftbeerpi3/modules/plugins/eManometer/__init__.py
             read -r -p "press enter to continue"
             show_menu
           else
             show_menu
           fi
           ;;
       27)
           confirmAnswer "Are you sure Restart CBPI3?"
           if [ $? = 0 ]; then
             sudo /etc/init.d/craftbeerpiboot stop
             sudo rm -rf logs/*.log
             sudo /etc/init.d/craftbeerpiboot start
             show_menu
           else
             show_menu
           fi
           ;;
       esac
   fi
}

if [ "$EUID" -ne 0 ]
  then whiptail --title "Please run as super user (sudo)" --msgbox "Please run the install file -> sudo install.sh " 8 78
  exit
fi

show_menu
