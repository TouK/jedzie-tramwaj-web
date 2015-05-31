'use strict'
angular.module 'app.routes', [
	'ui.router'
	'ct.ui.router.extras'
]

.config [
	'$locationProvider'
	'$stateProvider'
	'$urlRouterProvider'
	'$urlMatcherFactoryProvider'
	($locationProvider, $stateProvider, $urlRouterProvider, $urlMatcherFactoryProvider) ->
		# Without server side support html5 must be disabled.
		$locationProvider.html5Mode no

		$urlMatcherFactoryProvider.strictMode yes

		$urlRouterProvider
		.when '/przystanki/', '/przystanki'
		.otherwise '/przystanki'

		$stateProvider
		.state 'stops',
			url: '/przystanki'
			templateUrl: '/templates/stops/stops.html'
			controller: 'StopsController as sc'
			resolve:
				stops: [
					'stopsResource'
					'feedback'
					(stops, feedback) ->
						feedback.load()
						promise = stops.query().$promise
						promise.then (data) ->
							feedback.dismiss()
							return data
						return promise
				]

		.state 'stop',
			url: '/przystanek/:stopId'
			templateUrl: '/templates/stop/stop.html'
			controller: 'StopController as sc'
			resolve:
				stop: [
					'$stateParams'
					'stopsResource'
					'feedback'
					($stateParams, stops, feedback) ->
						feedback.load()
						promise = stops.get(id: $stateParams.stopId).$promise
						promise.then (data) ->
							feedback.dismiss()
							return data
						return promise

				]


]