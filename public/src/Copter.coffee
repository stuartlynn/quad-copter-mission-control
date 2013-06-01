class Copter 

	constructor: () ->
		@socket_connection = io.connect('http://0.0.0.0:3000/')
		@socket_connection.on 'navData', @updateNavData

	updateNavData:(data)=>
		$(".battery").html(data.demo.batteryPercentage+"%") 
		$(".speedX").html(data.demo.velocity.x )
		$(".speedY").html(data.demo.velocity.y )
		$(".speedZ").html(data.demo.velocity.z )
		$(".altitude").html(data.demo.altitudeMeters+" meters" )

window.Copter= Copter 

c = new Copter()