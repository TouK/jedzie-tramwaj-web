'use strict'

angular.module 'app.stop.controller', []

.controller 'StopController', [
	'$scope'
	'$timeout'
	'stop'
	'varsConfig'
	'feedback'
	class StopController
		constructor: ($scope, @timeout, @stop, @vars, @feedback) ->
			@refresh()
			$scope.$on '$destroy', @destructor

		refresh: =>
			@refreshInterval = @timeout =>
				@feedback.load()
				@stop.$get(id: @stop.id).then =>
					@refresh()
					@feedback.dismiss()
			, @vars.INTERVAL

		destructor: =>
			@timeout.cancel @refreshInterval
]