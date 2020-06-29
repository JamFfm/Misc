# !/usr/bin/env python
# -*- coding: utf-8 -*-
# this code exports sensor id, sensorname,value and unit to a return list[] selected by sensortype not sensor-name!
# Example return:
#
# ID 1 Sudhaustemperatur: 23.44°C
# or
# ID 5 Raspi_Temp: 48.3°C
#
# Sensortype can be eManometer, ONE_WIRE_SENSOR, PHSensor, SystemTempSensor, MQTT_SENSOR, etc.
# to detect all Sensor-types look at http://server_ip_of_cbpi:5000/api/sensor in the browser.
# server ip like 192.168.178.2 or localhost if running local, which will be most times
# if you use ip be aware of the dhcp function as the ip may change
# This code is made by Jam Ffm and only for CraftbeerPi 3.02

import requests

DEBUG = True


def get_api_sensor_values(sensortype, serverip='localhost'):
    r = requests.get("http://%s/api/sensor" % serverip)
    print (r.url)
    json_obj = r.json()

    if DEBUG: print (json_obj)
    if DEBUG: print (json_obj.keys())
    if DEBUG: print (json_obj.values())
    if DEBUG: print ("Len of list with keys %s" % len(json_obj.keys()))

    i = 0
    sensorlist = []

    while i < len(json_obj.keys()):
        
        json_obj_one_key = (list(json_obj.keys())[i])
        # print (json_obj_one_key)
        single_sensor = requests.get("http://%s/api/sensor/%s" % (serverip, json_obj_one_key))
        json_obj_single_sensor = single_sensor.json()
        # print (json_obj_single_sensor)
        # print (json_obj_single_sensor.keys())
        # print (json_obj_single_sensor.values())
        # print("Print each key-value pair from JSON response with Sensortype: %s % sensortype)

        for key, value in json_obj_single_sensor.items():
            if key == 'type' and value == sensortype:
                # if debug: print(json_obj_one_key, key, ":", value)
                sensor_value = json_obj_single_sensor['instance']['value']
                sensor_unit = json_obj_single_sensor['instance']['unit']
                sensor_name = json_obj_single_sensor['name']
                sensor_with_value = ('ID %s %s: %s%s' % (json_obj_one_key, sensor_name, sensor_value, sensor_unit))
                if DEBUG: print (sensor_with_value)
                sensorlist.append(sensor_with_value)
            pass
        pass
        i = i + 1
        pass
    return sensorlist


if __name__ == '__main__':
    sensor_result_list = get_api_sensor_values('eManometer', '192.168.0.122:4000')
    print (sensor_result_list)
    i = 0
    while i < (len(sensor_result_list)):
        print (sensor_result_list[i])
        i = i + 1
    pass
pass
