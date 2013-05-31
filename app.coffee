express = require('express')
app = module.exports = express.createServer()
io = require('socket.io')

app.configure =>
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router);
  app.use(express.static(__dirname + '/public'))


app.configure 'development', =>
  app.use express.errorHandler
  	dumpExceptions: true
  	showStack: true

app.configure 'production', =>
  app.use express.errorHandler()


app.listen(3000)
io.listen(app)
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
