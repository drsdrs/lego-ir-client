# test cmd =
# curl -H "Content-Type: application/json" -X POST -d '{"channel":"1","color":"B","dir":"M", "speed":"7"}' http://localhost:3000/



express = require('express');
app = express()


bodyParser = require('body-parser')
exec = require('child_process').exec


app.use( bodyParser.json() )


app.post '/', (req, res)->
  command = req.body.channel+req.body.color+"_"+ req.body.dir+req.body.speed 
  pfir command, (result)->
    res.send result
    console.log result
  console.log "sending command: "+command

pfir = (command, cb)->
  exec 'irsend SEND_ONCE LEGO_Single_Output '+command, (error, stdout, stderr)-> 
    if error then cb "\nERROR\n"
    else cb "\nOK\n"

app.listen 3000, ->
  console.log('Lego IR Client is ready on Port 3000')
