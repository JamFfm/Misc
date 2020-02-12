# eManometer Plugin for CraftBeerPi 3.0

Allows your eManometer digital Bottle Gauge / Spunding Valve to send data to CraftBeerPi 3.0, such as the current temperature, pressure readings, carbonation. The plugin allows you to create multiple sensors, each of which is associated with a different data type that the eManometer is capturing, so that you can use these sensors as you would any other sensor in CraftBeerPi.  You can also use multiple eManometers at the same time. See below for setup instructions and some screenshots of the configuration options.

## Configuration

### CraftBeerPi Configuration
1. In CraftBeerPi, click on the **System** menu, and then choose **Hardware Settings**.
2. Click the **Add** button in the Sensor section, and fill out the sensor properties:
    1. **Name**: Give the sensor a name. This is specific to this sensor reading, and does not need to match the eManometer device name. It can be something like Wort Gravity or eManometer Temperature.
    2. **Type**: Choose eManometer.
    3. **eManometer Name**: This should be set to the eManometer device name.
    4. **Data Type**: Each eManometer has many different types of data that it reports, such as Temperature, Pressure, and CO2, so select the one that you are configuring for this particular sensor.
3. Repeat the above steps if you want to additional sensors for the other data types that your eManometer reports, or if you have more than one eManometer, you can create sensors for those devices as well.
4. You can now add any of the eManometer sensors to kettles or fermenters in your brewery, or you can view their data on the dashboard or graph their data with the charts.
