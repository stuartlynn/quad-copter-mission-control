class Copter 

	constructor: () ->
		@socket_connection = io.connect('http://0.0.0.0:3000/')
		@socket_connection.on 'navData', @updateNavData
		@socket_connection.on 'pngStream', @updateImage

	updateNavData:(data)=>
		$(".battery").html(data.demo.batteryPercentage+"%") 
		$(".speedX").html(data.demo.velocity.x )
		$(".speedY").html(data.demo.velocity.y )
		$(".speedZ").html(data.demo.velocity.z )
		$(".altitude").html(data.demo.altitudeMeters+" meters" )

	updateImage:(data)=>
		console.log "got image"
		$(".video").attr("src", data)
		

window.Copter= Copter 

c = new Copter()