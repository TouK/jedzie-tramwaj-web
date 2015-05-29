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
		.when '/stops/', '/stops'
		.otherwise '/stops'

		$stateProvider
		.state 'stops',
			url: '/stops'
			templateUrl: '/templates/stops/stops.html'
			controller: 'StopsController as sc'
			resolve:
				stops: [
					'stopsResource'
					(stops) ->
						stops.query()
				]

		.state 'stop',
			url: '/stop/:stopId'
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