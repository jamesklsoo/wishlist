# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  console.log("hi");

  $('#chuckBtn').on('click', function() {
    console.log('working')
    $.ajax({
      type: "GET",
      url: 'https://api.chucknorris.io/jokes/random',
      success: function(response) {
        console.log(response)
        $('#joke').html(response.value)
      }
    })
  })
});