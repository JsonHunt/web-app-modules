express = require('express')
path = require('path')
service = require './payment-service'
router = express.Router()

router.use express.static(path.join(__dirname, 'client'))

router.use '/loadBalance', (req,res,next)->
	service.loadBalance req.body.token, (result)->


module.exports = router
