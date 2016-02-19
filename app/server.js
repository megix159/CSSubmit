/**
 * Server.js
 * @author Abdul Kadir
 * @date 2/19/16
 */

var app = require('express')();
var http = require('http').Server(app);
var mysql = require('mysql'); 
var bodyParser = require('body-parser');

//confige express to use body-parser to expose the requests
app.use(bodyParser.urlencoded({extended: false}));

/* mysql config data, 
   to create instance of connection:
   var connection = mysql.createConnection(mysqlConfig); */
var mysqlConfig = {
        host: 'localhost',
        user: 'root',
        password: '',
        database: '',
    };
