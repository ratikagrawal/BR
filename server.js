var express = require('express')
var app = express();

app.use(express.static('public'))

/*
app.get('/', function(req, res){
    res.send('Hello there\n')
})
*/

app.listen('8080', function(){
    console.log('server running on port 8080');
});