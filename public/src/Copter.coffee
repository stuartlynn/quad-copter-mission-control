class Copter 

	constructor: () ->
		@socket_connection = io.connect('http://0.0.0.0:3000/')
		@socket_connection.on 'navData', @updateNavData

		@socket_connection.on 'flightStarted', @flightStarted
		@socket_connection.on 'flightDone', @flightDone

		$(".instructions").submit (e)=>
			e.preventDefault();
			console.log "sending instructions", $(".drone_instructions").val()
			@socket_connection.emit 'instructions', {instructions: $(".drone_instructions").val()}

	updateNavData:(data)=>
		$(".battery").html(data.demo.batteryPercentage+"%") 
		$(".speedX").html(data.demo.velocity.x )
		$(".speedY").html(data.demo.velocity.y )
		$(".speedZ").html(data.demo.velocity.z )
		$(".altitude").html(data.demo.altitudeMeters+" meters" )

	flightStarted:=>
		$(".submit_button").hide()
		$("#flightStatus").html("FLYING").css("color","red")

	flightDone:=>
		$(".submit_button").show()
		$("#flightStatus").html("READY").css("color","green")

window.Copter= Copter 
$('document').ready =>
	c = new Copter()