class Commander

  constructor: (copter)->
    @copter= copter if copter?
    @movement_speed = 0.3
    @rotation_speed = 0.3

    @status = "waiting"
    @current_command_list = []

  parseCommands:(commandString)=>
    commands = commandString.trim().split("\n")
    commands = ({type : command.trim().split(" ")[0], duration:command.trim().split(" ")[1] }  for command in commands)
    console.log commands 
    commands

  runCommands:(commands, cb)=>
    if @status == "waiting"
      @current_command_list = @parseCommands(commands)
      @command_index = 0
      @done_cb = cb
      command = @current_command_list[@command_index]
      @status = "taking off"
      # @copter.takeOff =>
      @status= "flying"
      @[command.type](command.duration)
    else
      cb() if cb?
  next_command: =>
    @command_index += 1
    if @command_index == @current_command_list.length
      @copter.land() if @copter?
      @status  = "waiting"
      console.log "all done"
      @done_cb() if @done_cb?
    else
      console.log "stopping"
      @copter.stop() if @copter?
      setTimeout =>
        current_command = @current_command_list[@command_index]
        if @[current_command.type]?
          @[current_command.type](current_command.duration)
        else
          @next_command()
      ,1000

  up : (duration)=>
    console.log "going up for #{duration}"
    @copter.up(@movement_speed) if @copter?
    setTimeout  @next_command , duration * 1000


  down : (duration) =>
    console.log "going down for #{duration}"
    @copter.down(@movement_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  left : (duration) =>
    console.log "going left for #{duration}"
    @copter.left(@movement_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  clockwise : (duration)=>
    console.log "going clockwise for #{duration}"
    @copter.clockwise(@rotation_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  counterclockwise : (duration)=>
    console.log "going counterClockwise for #{duration}"
    @copter.counterClockwise(@rotation_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  right : (duration) =>
    console.log "going right for #{duration}"
    @copter.right(@movement_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  forward : (duration) =>
    console.log "going forward for #{duration}"
    @copter.front(@movement_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  backward : (duration) =>
    console.log "going backward for #{duration}"
    @copter.back(@movement_speed) if @copter?
    setTimeout  @next_command , duration * 1000

  wait : (duration, next_command)=>
    console.log "Waiting for #{duration}"
    setTimeout @next_command, duration*1000

module.exports = Commander