module.exports = ($q, $modal, $injector, $timeout,$location) ->
	# $timeout ()->
	# 	$http = $injector.get('$http')

	'response': (response) ->
		if response.data is 'NOT AUTHENTICATED'
			def = $q.defer()
			$modal.open
				templateUrl : 'module/auth/login.html'
				controller : require './login'
			.result.then (user)->
				http = $injector.get('$http')
				http(response.config).then (secondResponse)->
					def.resolve(secondResponse)
			, ()->
				def.reject("NOT AUTHENTICATED")
				$location.path('/')
			return def.promise
		else
			return response
