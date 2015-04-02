module.exports = UserStatsController = ($scope,$http) ->
	$http.get "/rest/getUserStats",
	.success (data,status,headers,config)->
		$scope.error = data.error
		$scope.stats = data.stats

	.error (data,status,headers,config)->
		$scope.error = data

UserStatsController.$inject = [ '$scope',$http ]
