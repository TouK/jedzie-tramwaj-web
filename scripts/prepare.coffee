require 'require-yaml'
require 'shelljs/global'

vars = require '../vars.yaml'
pkg = require '../package.json'

files = [
	'package.json'
	'bower.json'
	'config.coffee'
	'config.xml'
]

for file in files
	mv '-f', file+'.bak', file
	cp '-f', file, file+'.bak'
	sed '-i', "%appName%", pkg.name, file
	sed '-i', "%version%", pkg.version, file
	for key, value of vars
		sed '-i', "%#{key}%", value, file
