// Generated by CoffeeScript 1.9.1
(function() {
  module.exports = function($q, $modal, $injector, $timeout, $location) {
    return {
      'response': function(response) {
        var def;
        if (response.data === 'NOT AUTHENTICATED') {
          def = $q.defer();
          $modal.open({
            templateUrl: 'module/auth/login.html',
            controller: require('./login')
          }).result.then(function(user) {
            var http;
            http = $injector.get('$http');
            return http(response.config).then(function(secondResponse) {
              return def.resolve(secondResponse);
            });
          }, function() {
            def.reject("NOT AUTHENTICATED");
            return $location.path('/');
          });
          return def.promise;
        } else {
          return response;
        }
      }
    };
  };

}).call(this);