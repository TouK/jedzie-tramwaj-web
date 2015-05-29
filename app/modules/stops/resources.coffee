'use strict'

angular.module 'app.stops.resources', []

.factory 'stopsResource', [
	'$resource'
	'apiConfig'
	($resource, api) ->
		$resource "#{api.url}/przystanki/:id"
]