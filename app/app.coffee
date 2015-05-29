'use strict'

angular.module 'app', [
	# angular dependencies
	'ngAnimate'
	'ngResource'
	'ngSanitize'

	# external dependencies
	'angular-lodash'
	'angularSpinner'
	'angular-ladda'

	# jade / html templates and templates
	'templates'

	'config'
]

.config [
	'laddaProvider'
	(laddaProvider) ->
		laddaProvider.setOption
			style: 'slide-down'
]