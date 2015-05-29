exports.config =
# See docs at http://brunch.readthedocs.org/en/latest/config.html.
	conventions:
		assets: /^app[\/\\]assets/
		ignored: /^(bower_components[\/\\]bootstrap-less(-themes)?|app[\/\\]styles[\/\\]overrides|(.*?[\/\\])?[_]\w*)/
	modules:
		definition: false
		wrapper: false
	paths:
		public: 'www'
		watched: ['app', 'vendor']
	files:
		javascripts:
			joinTo:
				'js/app.js': /^app/
				'js/vendor.js': /^(bower_components|vendor)/
			order:
				before: [
					'bower_components/lodash/lodash.js'
				]

		stylesheets:
			joinTo:
				'css/vendor.css': /^(vendor|bower_components)/
				'css/app.css': /^(app)/
			order:
				before: [
					'bower_components/reset-css/reset.css'
				]
				after: []

		templates:
			joinTo:
				'js/templates.js': /^app.*[\/\\]templates[\/\\].*jade$/

	plugins:
		coffeescript:
			bare: no

		jadeNgtemplates:
			modules: [
				name: "templates"
				pattern: /^app[\/\\]templates[\/\\].*jade$/
				url: (path) ->
					name = path.replace(/^app[\/\\].*templates[\/\\](.*).jade$/, '$1').replace(/[\/\\]/g, '.')
					return "/templates/#{name}.html"
			,
				name: "templates.modules"
				pattern: /^app[\/\\].*[\/\\]templates[\/\\].*jade$/
				url: (path) ->
					dir = path.replace(/^app[\/\\]modules[\/\\](.*)templates[\/\\].*/, '$1')
					name = path.replace(/^app[\/\\]modules[\/\\].*templates[\/\\](.*).jade$/, '$1').replace(/[\/\\]/g, '.')
					return "/templates/#{dir}#{name}.html"
			]
			jade:
				pretty: yes
				doctype: "xml"
				basedir: 'app'
			htmlmin: no

		jadePages:
			pattern: /^app[\/\\]index.jade$/
			jade:
				pretty: yes
				doctype: "xml"
				basedir: 'app'
			htmlmin: no

		assetsmanager:
			copyTo:
				fonts: ['bower_components/bootstrap3/dist/fonts/*']
				img: ['bower_components/bootstrap2/img/*']



	server:
		port: 3334
		base: ''

	overrides:
		production:
			optimize: true #nie działa ta opcja na js - zawsze true
			sourceMaps: false






# export server configuration to jade processor
process?.server = exports.config.server
