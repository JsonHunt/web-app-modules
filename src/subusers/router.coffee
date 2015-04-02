express = require('express')
path = require('path')
service = require './user-service'
module.exports = router = express.Router()

router.use express.static(path.join(__dirname, 'client'))

router.use '/rest/getUsers', (req,res,next)-> service.getUsers req.body.filters, (err,users)-> res.json {error:err,users:users}
router.use '/rest/getUser', (req,res,next)-> service.getUser req.query.id, (err,user)-> res.json {error:err,user:user}
router.use '/rest/suspendUser', (req,res,next)-> service.suspendUser req.body.id, req.body.reason, (err)-> res.json {error:err}
router.use '/rest/unsuspendUser', (req,res,next)-> service.unsuspendUser req.body.id, req.body.reason, (err)-> res.json {error:err}
router.use '/rest/getUserStats', (req,res,next)-> service.getStats (err,stats)-> res.json {error:err,stats:stats}
