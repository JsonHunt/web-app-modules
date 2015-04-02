sql = require 'sql-bricks'
FastBricks = require 'fast-bricks'
emailjs   = require "emailjs/email"
uuid = require 'node-uuid'

fb = new FastBricks()
fb.loadConfig 'database-config.cson'
stripe = require("stripe")("sk_test_BQokikJOvBiI2HlWgH4olfQ2")

class PaymentService

	loadBalance: (user,token,amount,callback) ->
		payment:
			user_id: user.id
			stripe_token: token
			amount: amount
			time_paid: new Date()
			status: 'pending'
			mode: 'test'

		fb.query sql.insert('payment', payment), (err,result)->
			throw err if err
			payment.id = result.insertId

			charge = stripe.charges.create
				amount: amount
				currency: "usd"
				source: token
				description: "user.id"
			, (err,charge)->
				console.log charge
				if err
					changes =
						comment: err.toString()
						status:'rejected'
					fb.query sql.update('payment',changes).where({id: payment.id}), callback

module.exports = new PaymentService()
