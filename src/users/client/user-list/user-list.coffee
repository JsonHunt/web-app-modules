module.exports = UserListController = ($scope, $http) ->

	$http.post "/rest/getUsers",
	.success (data,status,headers,config)->
		$scope.error = data.error
		$scope.users = data.users
	.error (data,status,headers,config)->
		$scope.error = data

	$scope.selectUser = (user)->
		$scope.user = user
		$http.post "/rest/getUserPaymentHistory",
			id: user.id
		.success (data,status,headers,config)->
			if data.error
				$scope.error = data.error
			else
				user.payments = data.payments
		.error (data,status,headers,config)->
			$scope.error = data

UserListController.$inject = [ '$scope', '$http' ]
