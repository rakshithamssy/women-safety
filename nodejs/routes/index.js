var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Rakesh', something: 'Rakshitha' });
});

router.get('/register', function(req, res) {
	var db = req.db;
	var users = db.get('users');
    var added = new Date();
    req.query.added = added;

    users.find({ph_number: req.query.ph_number}, function(e, matches) {

        if(matches.length > 0) {
            res.send({
                'status': 'fail',
                'reason': 'user exists'
            });
            return;
        }

        users.insert(req.query);
        res.send({
            'status': 'ok',
            'user': req.query
        });
    });
});


router.get('/emergency', function(req, res) {
    var db = req.db;
    var users = db.get('users');

    users.find({ph_number: req.query.ph_number}, function(e, matches) {
        var user = false;
        console.log(matches);
        if (matches.length > 0){
            user = matches[0];
        }

        if (user) {
            res.send({
                'status': 'ok',
                'user': user.name
            });
        } else {
            res.send({
                'status': 'fail',
                'matches': matches.length
            });
        }
    });
});

router.get('/cancel_emergency', function(req, res) {
    var db = req.db;
    var users = db.get('users');

    users.find({phone_number: req.query.phone_number}, function(e, matches) {
        var user = false;
        if (matches.length > 0){
            user = matches[0];
        }

        if (user && user.secret == req.query.secret) {
            res.send({
                'status': 'ok',
                'user': user.name
            });
        } else {
            res.send({
                'status': 'fail',
                'matches': matches.length
            });
        }
    });
});

module.exports = router;

