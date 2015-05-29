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
					(stops) ->
						stops.query()
				]

		.state 'stop',
			url: '/przystanek/:stopId'
			templateUrl: '/templates/stop/stop.html'
			controller: 'StopController as sc'
			resolve:
				stop: [
					'$stateParams'
					'stopsResource'
					($stateParams, stops) ->
						stops.get id: $stateParams.stopId
				]


]