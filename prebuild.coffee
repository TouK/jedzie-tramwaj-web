require 'require-yaml'
require 'shelljs/global'

vars = require './vars.yaml'

files = [
	'package.json'
	'bower.json'
	'config.coffee'
	'config.xml'
]

for file in files
	mv '-f', file+'.bak', file
#	cp '-f', file, file+'.bak'
#	for key, value of vars
#		sed '-i', "%#{key}%", value, file
