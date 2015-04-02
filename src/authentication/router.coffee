express = require('express')
path = require('path')
AuthService = require './auth-service'
fs = require 'fs'

# fs.readFile "database-config.cson", (err,data)->
# 	console.log err if err

service = new AuthService("database-config.cson")
router = express.Router()

router.use express.static(path.join(__dirname, 'client'))

router.use '/getLogin', (req,res,next)->
	res.json
		user: req.session?.appuser

router.use '/login', (req, res, next) ->
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

router.use '/logout', (req,res,next)->
	delete req.session.appuser
	res.send 'ok'

router.use '/signup', (req,res,next)->
	service.signup req.body.user, (err,user)->
		res.json
			error: err
			user: user

router.use '/activateAccount', (req,res,next)->
	code = req.query.code
	service.activateUser code, (err)->
		res.json
			error: err

router.use '/requestPasswordReset', (req,res,next)->
	service.requestPasswordReset req.body.email, (err)->
		res.json
			error: err

router.use '/resetPassword', (req,res,next)->
	service.resetPassword req.query.code, (err,user)->
		if err
			res.redirect "reset-password-error.html"
		else
			req.session.appuser = user
			res.redirect "/#/change-password"

router.use '/changePassword', (req,res,next)->
	password = req.body.password
	service.changePassword user, password, (err)->
		res.json
			error: err



module.exports = router
