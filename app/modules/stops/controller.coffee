'use strict'

angular.module 'app.stops.controller', []

.controller 'StopsController', [
	'stops'
	'$interval'
	class StopsController
		constructor: (@stops, $interval) ->
			$interval =>
				console.log @stops
#				@stops.query()
			, 2000
]