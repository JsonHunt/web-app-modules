module.exports = LoginController = ($scope,$http,$modalInstance,$rootScope) ->

	setTimeout ()->
		$('#username').focus()
	,100

	$scope.login = ()->
		# $http = $injector.invoke(($http) ->
		# 	$http
		# )
		$http.post 'module/auth/login',
			username: @username
			password: @password
		.error (data,status,headers,config)-> $scope.error = data
		.success (data,status,headers,config)->
			if data.error
				$scope.error = data.error
			else
				$rootScope.user = data.user
				$modalInstance.close data.user

	$scope.passwordReset = ()->
		$scope.resetting = true
		delete $scope.error
		setTimeout ()->
			$('.focusme').focus()
		,100
		# $ocModal.open
		# 	id: 'modal2',
		# 	url: 'password-reset/password-reset.html'
		# 	controller: require './../password-reset/password-reset'

	$scope.resetContinue = ()->
		if not $scope.email or $scope.email.length is 0
			$scope.error = "Email is required"
			return

		$http.post "module/auth/requestPasswordReset",
			email: $scope.email
		.success (data,status,headers,config)->
			$scope.error = data.error
			if !data.error
				$scope.sent = true
		.error (data,status,headers,config)-> $scope.error = data

	$scope.close = ()->
		$ocModal.close()

	$scope.resetCancel = ()->
		$scope.resetting = false
		delete $scope.error
		setTimeout ()->
			$('#username').focus()
		,100

LoginController.$inject = [ '$scope','$http','$modalInstance','$rootScope' ]
