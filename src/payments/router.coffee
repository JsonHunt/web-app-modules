express = require('express')
path = require('path')
service = require './payment-service'
router = express.Router()

router.use express.static(path.join(__dirname, 'client'))




module.exports = router
