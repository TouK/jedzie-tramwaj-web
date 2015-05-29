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
	sed '-i', "%appName%", (vars.name or pkg.name), file
	sed '-i', "%version%", (vars.version or pkg.version), file
	for key, value of vars
		sed '-i', "%#{key}%", value, file

if vars.name
	sed '-i', "\"name\": \"#{pkg.name}", "\"name\": \"#{vars.name}", 'package.json'
if vars.version
	sed '-i', "\"version\": \"#{pkg.version}", "\"version\": \"#{vars.version}", 'package.json'
