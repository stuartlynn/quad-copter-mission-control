{spawn, exec} = require 'child_process'
 
task 'watch', 'Watch source files and build JS & CSS', (options) ->
  runCommand = (name, args...) ->
    proc =           spawn name, args
    proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
    proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
    proc.on          'exit', (status) -> process.exit(1) if status isnt 0
  
  runCommand 'coffee', '-wc', '-o', 'public/javascripts/', 'public/src'
  runCommand 'node_modules/stylus/bin/stylus', '-w', 'public/stylesheets/', '-o', 'public/stylesheets/'