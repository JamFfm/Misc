# -*- coding: utf-8 -*-
import os
from subprocess import Popen, PIPE, call

from modules import cbpi
import json
from flask import Blueprint, render_template, jsonify, request, url_for

from os import listdir
import csv

BetterChart = Blueprint('BetterChart', 
               __name__, 
               static_url_path = '/modules/plugins/cbpi-BetterChart/static',
               static_folder = './static',
               template_folder = './template')

@BetterChart.route('/', methods=['GET'])
def start():
    logs=find_log_filenames()
    
    return render_template('BetterChart.html', logs = sorted(logs))
    
@BetterChart.route('/<name>', methods=['GET'])
def chart(name):
    logs=find_log_filenames()
    
    data = []
    with open('./logs/'+name) as file:
        csvReader = csv.reader(file)
        for row in csvReader:
            row[0] = row[0].replace("-", "/")
            print (row[0])
            data.append(row)
    
    #print (data)
    
    return render_template('chart.html', log = name, logs = sorted(logs), data = data)

def find_log_filenames( path_to_dir='./logs', suffix=".log" ):
    filenames = listdir(path_to_dir)
    return [ filename for filename in filenames if filename.endswith( suffix ) and filename != "app.log" and filename != "action.log"]


@cbpi.initalizer()
def init(cbpi):
    cbpi.app.register_blueprint(BetterChart, url_prefix='/BetterChart')


#@cbpi.initalizer(order=100)
#def init(cbpi):
#    index="./modules/ui/static/index.html"
#
#    # read the file into a list of lines
#    lines = open(index, 'r').readlines()
#
#    # now edit the last line of the list of lines
#    new_last_line = (lines[-1].rstrip() + '<footer class="footer navbar navbar-default"> <div class="container"> <div class="navbar-header"> <a href="#" class="navbar-brand">Extended Menu</a> </div><ul class="nav navbar-nav"><li><a href="/BetterChart">BetterChart</a></li></ul> </div></footer> <style>/* Sticky footer styles-------------------------------------------------- */html{position: relative; min-height: 100%;}body{margin-bottom: 60px; /* Margin bottom by footer height */}.footer{position: absolute; bottom: 0; width: 100%; height: 60px; /* Set the fixed height of the footer here */ line-height: 60px; /* Vertically center the text there */ background-color: #f5f5f5;}/* Custom page CSS-------------------------------------------------- *//* Not required for template or sticky footer method. */.container{width: auto; max-width: 680px; padding: 0 15px;}</style>')
#    lines[-1] = new_last_line
#
#    # now write the modified list back out to the file
#    open(index, 'w').writelines(lines)

