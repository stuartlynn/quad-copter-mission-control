// Generated by CoffeeScript 1.6.2
(function() {
  var Copter,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    _this = this;

  Copter = (function() {
    function Copter() {
      this.flightDone = __bind(this.flightDone, this);
      this.flightStarted = __bind(this.flightStarted, this);
      this.updateNavData = __bind(this.updateNavData, this);
      var _this = this;

      this.socket_connection = io.connect('http://0.0.0.0:3000/');
      this.socket_connection.on('navData', this.updateNavData);
      this.socket_connection.on('flightStarted', this.flightStarted);
      this.socket_connection.on('flightDone', this.flightDone);
      $(".instructions").submit(function(e) {
        e.preventDefault();
        console.log("sending instructions", $(".drone_instructions").val());
        return _this.socket_connection.emit('instructions', {
          instructions: $(".drone_instructions").val()
        });
      });
    }

    Copter.prototype.updateNavData = function(data) {
      $(".battery").html(data.demo.batteryPercentage + "%");
      $(".speedX").html(data.demo.velocity.x);
      $(".speedY").html(data.demo.velocity.y);
      $(".speedZ").html(data.demo.velocity.z);
      return $(".altitude").html(data.demo.altitudeMeters + " meters");
    };

    Copter.prototype.flightStarted = function() {
      $(".submit_button").hide();
      return $("#flightStatus").html("FLYING").css("color", "red");
    };

    Copter.prototype.flightDone = function() {
      $(".submit_button").show();
      return $("#flightStatus").html("READY").css("color", "green");
    };

    return Copter;

  })();

  window.Copter = Copter;

  $('document').ready(function() {
    var c;

    return c = new Copter();
  });

}).call(this);
