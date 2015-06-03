'use strict'

class History
	$replace: no
	constructor: ($scope, @$state, homeState) ->
		@$states = if homeState?.name then [
			state: homeState.name
			params: homeState.params or {}
		] else []

		$scope.$on '$stateChangeSuccess', (event, state, params) =>
			@add state.name, params

		angular.extend $scope, $history: @

		$scope.$watch (=> @$states), =>
			console.debug 'history', @$states
		, yes

	add: (state, params) =>
		current =
			state: state
			params: params
		if @$replace
			@$states.pop()
		if state.length > 0 and not _.eq @last(), current
			@$states.push current
		@$replace = no
	#			@clean() if _.eq _.first(@$states), @last()

	replace: => @$replace = yes

	last: => _.last @$states

	hasPrevious: => @$states.length > 1

	clean: =>
		@$replace = no
		@$states = _.takeRight @$states

	back: (steps = 1) =>
		@$replace = no
		if @hasPrevious()
			@$states = _.dropRight @$states, steps
			last = @last()
			@$state.transitionTo last.state, last.params,
				location: 'replace'

class HistoryProvider
	setHomeState: (@homeState) =>
	$get: [
		'$rootScope', '$state'
		$historyFactory = ($rootScope, $state) ->
			new History arguments..., @homeState
	]

angular.module 'touk.cordova.locationHistory', []

.provider '$history', HistoryProvider

.run [
	'$history', '$timeout', '$rootScope'
	($history, $timeout, $rootScope) ->
		document.addEventListener 'backbutton', (event) ->
			event.preventDefault()
			$history.back() or $rootScope.$broadcast 'EXIT_APP'
		, false

		$rootScope.$on 'EXIT_APP', ->
			console.debug 'EXIT_APP'
			navigator?.app?.exitApp?()
]