$(document).ready(function() {
  $("[data-toggle]").click( function(){
    var string = $("[data-toggle]").data("toggle")
    $(string).toggle()
  })
})

