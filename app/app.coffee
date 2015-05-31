'use strict'

WebFont.load google:
	families: [
		'Oswald:300,400,700:latin,latin-ext'
		'Comfortaa:300,400,700:latin,latin-ext'
#		'PT+Sans+Narrow:400,700:latin,latin-ext'
#		'Roboto+Condensed:300,400,700:latin,latin-ext'
#		'Roboto:100,300,400,500,700,900:latin,latin-ext'
	]

angular.module 'app', [
	# angular dependencies
	'ngAnimate'
	'ngResource'
	'ngSanitize'

	# external dependencies
	'duScroll'
	'angularSpinner'
	'angular-ladda'
	'feedback'

	# jade / html templates and templates
	'templates'

	'config'
]

.config [
	'laddaProvider'
	'usSpinnerConfigProvider'

	(laddaProvider, usSpinnerConfigProvider) ->
		laddaProvider.setOption
			style: 'slide-down'

		usSpinnerConfigProvider.setDefaults
			color: '#ff5500'
			corners: 0
			opacity: 0
			length: 0
			speed: 1.2
			trail: 70
			radius: 40
			width: 12
			lines: 16


]