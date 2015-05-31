'use strict'

angular.module 'app.stops.controller', []

.controller 'StopsController', [
	'$scope'
	'$interval'
	'$document'
	'stops'
	'varsConfig'
	class StopsController
		constructor: ($scope, @interval, @document, @stops, vars) ->
#			@refreshInterval = @interval @refresh, vars.INTERVAL
#			$scope.$on '$destroy', @destructor
#
#		refresh: => console.log @stops
#		destructor: =>
#			@interval.cancel @refreshInterval

]

.filter 'groupByFirst', [
	-> _.memoize (elements, param) ->
		_.groupBy elements, (item) ->
			item[param][0]

]