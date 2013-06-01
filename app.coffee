express = require('express')
app = module.exports = express.createServer()
copter = require('ar-drone').createClient()
socketio = require('socket.io')


pngStream = copter.getPngStream()

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

  pngStream.on 'pngStream', (data)=>
  	console.log "\n\nGOT IMAGE \n\n"
  	socket.emit('pngStream', data)


copter.on('navdata', console.log);

console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);