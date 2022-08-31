$('.btn-1').on('click',function(){
  $.post("http://nfr_cautator_aur/ofera", JSON.stringify({}));
  var btn = $(this);
  btn.prop('disabled', true);
  setTimeout(function(){
    btn.prop('disabled', false);
  },10000);
})
$('.btn-2').on('click',function(){
  $.post("http://nfr_cautator_aur/ofera2", JSON.stringify({}));
  var btn = $(this);
  btn.prop('disabled', true);
  setTimeout(function(){
    btn.prop('disabled', false);
  },10000);
})



function display(bool) {
  if (bool) {
      $(".tot").show();

  } else {
      $(".tot").hide();
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
          $.post("http://nfr_cautator_aur/exit", JSON.stringify({}));
          return
      }
  };
