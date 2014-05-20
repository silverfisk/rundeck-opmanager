#!/usr/bin/env ruby
require 'rest_client'
require 'json'
require 'yaml'

responsejson = JSON.parse(RestClient.get('https://192.168.1.1/api/json/device/listDevices?apiKey=12345678901234567890123456789012'))

responseyaml = YAML::dump(responsejson)

print responseyaml
