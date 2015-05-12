require 'shelljs/global'

for file in find('.').filter((file) -> return file.match /\.bak$/)
	mv '-f', file, file.replace('.bak', '')

rm '-rf', [
	'www'
	'plugins'
	'platforms'
	'coverage'
	'test.results.xml'
	'*.log'
]