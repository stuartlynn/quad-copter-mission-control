express = require('express')
app = module.exports = express.createServer()
copter = require('ar-drone').createClient()

Commander = require("./Commander")
@commander = new Commander(copter)

socketio = require('socket.io')

@movement_speed = 0.3

require('ar-drone-png-stream')(copter, { port: 3002 })
logo_interface = require('logo-drone')(copter)


app.configure =>
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

app.configure 'development', =>
  app.use express.errorHandler
  	dumpExceptions: true
  	showStack: true

app.configure 'production', =>
  app.use express.errorHandler()

app.listen(3000)
io = socketio.listen(app)

io.sockets.on 'connection', (socket)=>
	copter.on 'navdata', (data) =>
  	socket.emit('navData',data);

	socket.on 'instructions', (data)=>
    if data?
      console.log "received instructions #{data.instructions}" 
      socket.emit('flightStarted')
		  @commander.runCommands data.instructions, =>
        console.log("\n\nHERE\n\n")
        socket.emit('flightDone')

stop = =>
  copter.stop()



console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);