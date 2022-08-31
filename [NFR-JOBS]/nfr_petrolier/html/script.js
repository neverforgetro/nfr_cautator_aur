$('.button-1').on('click',function(){
  $.post("http://nfr_petrolier/start", JSON.stringify({}));
  var btn = $(this);
  btn.prop('disabled', true);
  setTimeout(function(){
    btn.prop('disabled', false);
  },15000);
})

$('.button-2').on('click',function(){
  $.post("http://nfr_petrolier/stop", JSON.stringify({}));
  
})

function display(bool) {
  if (bool) {
      $(".container").show();

  } else {
      $(".container").hide();
  }
}




display(false)


window.addEventListener('message', function(event) {
  var item = event.data;
  if (item.type === "ui") {
      if (item.status == true) {
          display(true)
      } else {
          display(false)
      }
  }
})

    document.onkeyup = function(data) {
      if (data.which == 27) {
          $.post("http://nfr_petrolier/exit", JSON.stringify({}));
          return
      }
  };
