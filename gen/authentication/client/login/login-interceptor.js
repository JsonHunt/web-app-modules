// Generated by CoffeeScript 1.9.0
(function() {
  var LoginInterceptor;

  module.exports = LoginInterceptor = function($q, $modal, $injector) {
    return {
      'self': this,
      'request': function(config) {
        return config;
      },
      'requestError': function(rejection) {
        return $q.reject(rejection);
      },
      'response': function(response) {
        var def, modalInstance;
        if (response.data === 'NOT AUTHENTICATED') {
          def = $q.defer();
          modalInstance = $modal.open({
            templateUrl: 'login/login.html',
            controller: require('./login')
          });
          modalInstance.result.then(function(result) {
            var $http;
            $http = $injector.invoke(function($http) {
              return $http;
            });
            return $http(response.config).then(function(secondResponse) {
              return def.resolve(secondResponse);
            });
          }, function() {
            return def.reject("NOT AUTHORIZED");
          });
          return def.promise;
        } else {
          return response;
        }
      },
      'responseError': function(rejection) {
        return $q.reject(rejection);
      }
    };
  };

}).call(this);
