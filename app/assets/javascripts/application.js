// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require "jquery_ujs"
//= require_tree .


function calculateCenter(coordinates) {
  var outboundCoordinates = this.getOutboundCoordinates(coordinates);
  var maxLat = outboundCoordinates.maxLat;
  var minLat = outboundCoordinates.minLat;
  var maxLng = outboundCoordinates.maxLng;
  var minLng = outboundCoordinates.minLng;

  return {
    lat: (maxLat + minLat) / 2,
    lng: (maxLng + minLng) / 2
  };
}

function getOutboundCoordinates(coordinates) {
  let maxLat = undefined;
  let minLat = undefined;
  let maxLng = undefined;
  let minLng = undefined;

  for (let i = 0; i < coordinates.length; i++) {
    let coordinate = coordinates[i];
    if (maxLat === undefined) {
      maxLat = coordinate.lat;
    }

    if (minLat === undefined) {
      minLat = coordinate.lat;
    }

    if (maxLng === undefined) {
      maxLng = coordinate.lng;
    }

    if (minLng === undefined) {
      minLng = coordinate.lng;
    }

    maxLat = Math.max(maxLat, coordinate.lat);
    minLat = Math.min(minLat, coordinate.lat);
    maxLng = Math.max(maxLng, coordinate.lng);
    minLng = Math.min(minLng, coordinate.lng);
  }

  return {
    maxLat: maxLat,
    minLat: minLat,
    maxLng: maxLng,
    minLng: minLng
  };
}

function fitBounds(map, coordinates) {
  var outboundCoordinates = this.getOutboundCoordinates(coordinates);
  var bounds = new google.maps.LatLngBounds();

  bounds.extend(
    new google.maps.LatLng(
      outboundCoordinates.maxLat,
      outboundCoordinates.maxLng
    )
  );
  bounds.extend(
    new google.maps.LatLng(
      outboundCoordinates.maxLat,
      outboundCoordinates.minLng
    )
  );
  bounds.extend(
    new google.maps.LatLng(
      outboundCoordinates.minLat,
      outboundCoordinates.maxLng
    )
  );
  bounds.extend(
    new google.maps.LatLng(
      outboundCoordinates.minLat,
      outboundCoordinates.minLng
    )
  );
  map.fitBounds(bounds);
}
