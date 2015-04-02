sql = require 'sql-bricks'
FastBricks = require 'fast-bricks'
emailjs   = require "emailjs/email"
uuid = require 'node-uuid'
async = require 'async'
xdate = require 'xdate'

fb = new FastBricks()
fb.loadConfig 'database-config.cson'

class UserService

	getUsers: (filters, callback)->
		expr = sql.select().from('user')
		expr.where(filters) if filters
		fb.query expr, callback

	getUser: (id, callback)->
		fb.query sql.select().from('user').where({id:id}), callback

	suspendUser: (id,reason,callback)->
		fb.query sql.update('user',{suspended: true, suspension_reason:reason}).where({id:id}), callback

	unsuspendUser: (id,reason,callback)->
		fb.query sql.update('user',{suspended: false, suspension_reason:reason}).where({id:id}), callback

	getStats: (callback)->
		weekago = new xdate(new Date())
		weekago.addDays(-7)
		async.parallel [
			(cb)-> fb.query sql.select('count *').from('user'), cb
			(cb)-> fb.query sql.select('count *').from('user').where({verified:true}), cb
			(cb)-> fb.query sql.select('count *').from('user').where({suspended:true}), cb
			(cb)-> fb.query sql.select('count *').from('user').where(sql.gt({date_registered:weekago.toDate()})), cb
			(cb)-> fb.query sql.select('sum (amount)').from('payment').where(sql.gt({date_paid:weekago.toDate()})), cb
		], (err,results)->
			if !err
				stats = {
					total: results[0][0]
					verified: results[1][0]
					suspended: results[2][0]
					registered_7_days: results[3][0]
					payment_7_days: results[4][0]
				}
			callback err,stats
