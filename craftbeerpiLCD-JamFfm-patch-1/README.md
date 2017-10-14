# LCD add-on for CraftBeerPi 3

With this add-on you can display your Brewing steps temperatures on a 20x4 i2c LCD Display.
In addition you can display the target-temperatur and current-temperature of each fermenter.
This addon only works with I2C connected LCD Displays.
There are 3 different modes:

Multidisplay mode
-----------------

> The script will loop thru your kettles and display the target and
> current temperatur. In timer Mode it displayes the remaining time of
> the step (rest) when target temperature is reached.

Single mode
-----------

> Only displayes one kettle but reacts a little bit faster on temperature changes. 
> In timer mode it displayes the remaining time of
> the step (rest) when target temperature is reached.
> When the heater in on a small beerglas is blinking in the first row on the right side.
> During timermode the "countdown" is displayed.

Fermenter mode
--------------
> Pretty much the same as multidisplay for all fermenter.
> Displayes the brewname, fermentername, target-temperature, current-temperature
> of each fermenter.
> When the heater or cooler of the fermenter is on it will show a symbol.
> A beerglas detects heater is on, * means cooler in on.
> Fermenter mode starts when a fermenter-step of any of the fermenters ist startet.

Parameter
---------

There are several parameter to change in the **CBPi-parameter** menue:
>
>
> **LCD_Adress:**    
> This is the adress of the LCD modul. You can detect it by 
> using the following command in the commandbox of the Raspi:   
> sudo i2cdetect -y 1 
> or 
> sudo i2cdetect -y 0.
> Default 0x27.
> 
> 
> **LCD_Multidisplay:**     
> Changes between the 2 modes. "on" means the Multidisplaymode is on. 
> "off" means singledisplaymode is on. Default "on". 
> 
>
> **LCD_Refresh:**		  
> In Multidisplay mode this is the time to wait until switching to next displayed kettle. 
> Default 5 sec.
> 
> 
> **LCD_Singledisplay:** 	  
> Here you can change the kettle to be displayed in single mode. The number is the same as row number  of
> kettles starting with 1. Default is kettle 1 (probably the first kettle which was defined in hardware).

Defaultdisplay
--------------

> If no brewing process is running the LCD Display will show
> 
> -CraftBeerPi-Version 
> -current IP adress 
> -current date/time

## Installation

> Download and install this plugin via 
> the CraftBeerPi user interface. It is called LCDDisplay.
> After that a reboot is necessary.

## Configuration

> At least configure your i2c adress in the parameters menue. Some other
> parameters of the LCD can be changed in the  __init__.py file in the
> /home/pi/craftbeerpi3/modules/plugins/LCDDisplay folder.

## Hints

> Changing a LCD_xxxx parameter in the parameters menue or any
> file in LCDDisplay folder always requires a reboot.
> A new fermenter should have a target temperature and at least one step defined.

