module.exports =
	payment:
		loadBalance: require './payments/client/load-balance'
	auth:
		changePassword: require './authentication/client/change-password'
		login: require './authentication/client/login'
		loginInterceptor: require './authentication/client/login-interceptor'
		signup: require './authentication/client/signup'
