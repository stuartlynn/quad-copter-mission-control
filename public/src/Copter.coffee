class Copter 

	constructor: () ->
		@socket_connection = io.connect('http://localhost:3000')
		@socket_connection.on 'navData', @updateNavData
		@socket_connection.on 'pngStream', @updateImage

	updateNavData:(data)=>
		console.log "nav data ", data 

	updateImage:(data)=>
		console.log "image", data 

window.Copter= Copter 

c = new Copter()