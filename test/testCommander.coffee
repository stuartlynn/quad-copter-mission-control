Commander = require("../Commander")

com = new Commander()

commands = """
	up 1
	left 0.2 
	forward 0.7
	down 0.5
	back 0.2
	clockwise 0.2
	counterclockwise 0.3
"""
com.runCommands commands, =>
	console.log("all done now")

com.runCommands commands, =>
	console.log("should return imedietly")