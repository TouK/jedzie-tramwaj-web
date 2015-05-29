'use strict'

angular.module 'app.stop.controller', []

.controller 'StopController', [
	'stop'
	'$interval'
	'varsConfig'
	class StopController
		constructor: (@stop, $interval, vars) ->
			$interval @refresh, vars.INTERVAL

		refresh: => @stop.$get id: @stop.id
]