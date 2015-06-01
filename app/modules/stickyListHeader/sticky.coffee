'use strict'

angular.module 'app.stickyListHeader.sticky', []

.service 'cssTransform', class

	set: (transform) =>
		transform: "#{transform}"
		msTransform: "#{transform}"
		webkitTransform: "#{transform}"
		mozTransform: "#{transform}"
		oTransform: "#{transform}"

	create: (options) =>
		return @set options if angular.isString options
		transform = ''
		for name, value of options
			transform = transform + "#{name}(#{value})"
		@set transform


.controller 'StickyTitles', [
	'$animate'
	'$timeout'
	'cssTransform'
	class StickyTitles
		buffer: 2

		constructor: (@animate, @timeout, @cssTransform) ->
			@titles = []

		add: (title) =>
			title.wrap '<div class="sticky-wrap" />'
			@update title
			@titles.push title

		remove: (title) => @titles = _.without @titles, title

		update: (current) =>
			current
			.css width: "#{@scroller[0].clientWidth}px"
			.parent().css
				height: current[0].clientHeight + 'px'
			current.pos = current[0].offsetTop

		updateAll: =>
			for element, i in @titles
				@unFixTitle element, @titles[i+1]

		fixTitle: (current, next) =>
			current.addClass 'fixed'
			return unless next

			currentHeight = current[0].clientHeight
			nextTop = next?[0].offsetTop - @scroller[0].scrollTop
			if (@scroller[0].scrollTop >= next.pos - currentHeight and nextTop >= 0)
				current.css @cssTransform.create "translate3d(0,#{nextTop - currentHeight}px,0)"
			else if nextTop < @buffer
				current.css @cssTransform.create "rotateX(90deg)"
			else
				current.css @cssTransform.create "translate3d(0,0,0)"

		unFixTitle: (current, next) =>
			current.removeClass 'fixed'
			@update current

		scroll: => do @scroll = _.throttle =>
			for current, i in @titles
				next = @titles[i+1]
				if current.pos - @buffer <= @scroller[0].scrollTop
					@fixTitle current, next
				else
					@unFixTitle current, next
		, 50

]

.directive 'stickyTitles', [
	'$window'
	($window) ->
		controller: 'StickyTitles'
		link: (scope, element, attrs, ctrl) ->
			ctrl.scroller = element
			element.on 'scroll scrollstart scrollend mousewheel touchstart touchend touchmove gesturechange', -> ctrl.scroll()
			angular.element($window).on 'resize', -> ctrl.updateAll()

]

.directive 'stickyTitle', [
	'$timeout'
	($timeout) ->
		require: '^stickyTitles'
		link: (scope, element, attrs, ctrl) ->
			scope.$on '$destroy', -> ctrl.remove element
			ctrl.add element
]