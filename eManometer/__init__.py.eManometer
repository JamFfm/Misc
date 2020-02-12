# -*- coding: utf-8 -*-

# addon for eManometer

import os
from subprocess import Popen, PIPE, call

from modules import cbpi, socketio
from modules.core.hardware import SensorActive
import json
from flask import Blueprint, render_template, jsonify, request
from modules.core.props import Property

debug = False

blueprint = Blueprint('emanometer', __name__)
cache = {}

@cbpi.sensor
class eManometer(SensorActive):
	key = Property.Text(label="eManometer Name", configurable=True, description="Enter the name of your eManometer")
	sensorType = Property.Select("Data Type", options=["Temperature", "Pressure", "CO2"], description="Select which type of data to register for this sensor")

	def get_unit(self):
		if self.sensorType == "Temperature":
			return "°C" if self.get_config_parameter("unit", "C") == "C" else "°F"
		elif self.sensorType == "Pressure":
			return "bar"
		elif self.sensorType == "CO2":
			return "g/l"
		else:
			return " "

	def stop(self):
		pass

	def execute(self):
		global cache
		while self.is_running():
			try:				
				if cache[self.key] is not None:
					reading = cache[self.key][self.sensorType]
					if debug:
						cbpi.app.logger.info("eManometer - reading " + str(reading))
					self.data_received(reading)
			except:
				pass
			self.api.socketio.sleep(1) 


@blueprint.route('/api/emanometer/v1/data', methods=['POST'])
def set_temp():
	global cache
	
	data = request.get_json()
	id = data["name"]
	temp = round(float(data["temperature"]), 2)
	pressure = round(data["pressure"], 3)
	co2 = round(data["co2"], 2)

	cache[id] = {'Temperature': temp, 'Pressure': pressure, 'CO2': co2}

	return ('', 204)

@cbpi.initalizer()
def init(cbpi):
	cbpi.app.logger.info("eManometer  - init")
	cbpi.app.register_blueprint(blueprint)
