// Generated by CoffeeScript 1.9.0
(function() {
  var FastBricks, PaymentService, emailjs, fb, sql, uuid;

  sql = require('sql-bricks');

  FastBricks = require('fast-bricks');

  emailjs = require("emailjs/email");

  uuid = require('node-uuid');

  fb = new FastBricks();

  fb.loadConfig('database-config.cson');

  PaymentService = (function() {
    function PaymentService() {}

    return PaymentService;

  })();

  module.exports = new PaymentService();

}).call(this);
