// Generated by CoffeeScript 1.6.2
(function() {
  var Copter, c,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Copter = (function() {
    function Copter() {
      this.updateImage = __bind(this.updateImage, this);
      this.updateNavData = __bind(this.updateNavData, this);      this.socket_connection = io.connect('http://0.0.0.0:3000/');
      this.socket_connection.on('navData', this.updateNavData);
      this.socket_connection.on('pngStream', this.updateImage);
    }

    Copter.prototype.updateNavData = function(data) {
      $(".battery").html(data.demo.batteryPercentage + "%");
      $(".speedX").html(data.demo.velocity.x);
      $(".speedY").html(data.demo.velocity.y);
      $(".speedZ").html(data.demo.velocity.z);
      return $(".altitude").html(data.demo.altitudeMeters + " meters");
    };

    Copter.prototype.updateImage = function(data) {
      console.log("got image");
      return $(".video").attr("src", data);
    };

    return Copter;

  })();

  window.Copter = Copter;

  c = new Copter();

}).call(this);
