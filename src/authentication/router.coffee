express = require('express')
path = require('path')
service = require './auth-service'
router = express.Router()

router.use express.static(path.join(__dirname, 'client'))

router.use '/rest/getLogin', (req,res,next)->
	res.json
		user: req.session?.appuser

router.use '/rest/login', (req, res, next) ->
	try
		service.login req.body.username, req.body.password, (err,user)->
			if !err and user
				req.session.appuser = user
			res.json
				error: err
				user: user
	catch e
		res.json
			error: e

router.use '/rest/logout', (req,res,next)->
	delete req.session.appuser
	res.send 'ok'

router.use '/rest/signup', (req,res,next)->
	service.signup req.body.user, (err,user)->
		res.json
			error: err
			user: user

router.use '/rest/activateAccount', (req,res,next)->
	code = req.query.code
	service.activateUser code, (err)->
		res.json
			error: err

router.use '/rest/requestPasswordReset', (req,res,next)->
	service.requestPasswordReset req.body.email, (err)->
		res.json
			error: err

router.use '/rest/resetPassword', (req,res,next)->
	service.resetPassword req.query.code, (err,user)->
		if err
			res.redirect "reset-password-error.html"
		else
			req.session.appuser = user
			res.redirect "/#/change-password"

router.use '/rest/changePassword', (req,res,next)->
	user = req.session.appuser
	if !user
		res.send "NOT AUTHENTICATED"
	else
		password = req.body.password
		service.changePassword user, password, (err)->
			res.json
				error: err



module.exports = router
