var options = undefined;
var hasCreatedButtons = [];

window.addEventListener('message', function(event) {
	
	item = event.data;
	switch (event.data.action) {
		case 'openDialog':
			options = item.options;
			$('#npc-header').html(item.header);
			$('#npc-name').html(item.name);
			$('#dialog').html(item.dialog);
			for (let i = 0; i < item.options.length; i++) {
				if(i <= 8){
					$("#option"+i).show();
					$("#option"+i).html(item.options[i][0]);
					if(!hasCreatedButtons[i]){
						$(document).on('click', "#option"+i, function() {
							$.post('https://vrp_jobs/action', JSON.stringify ({
								action: "option",
								options: options[i],
							}));
							$('body').fadeOut();
						});
						hasCreatedButtons[i] = true;
					}
				}
				if(i < 8){
					for (let i = item.options.length; i < 8; i++){
						$("#option"+i).hide();
					}
				}
			}
			$('body').fadeIn();
		break
	}
});

$(document).on('click', ".btn-closeinterface", function() {
	$('body').fadeOut();
	$.post('https://vrp_jobs/action', JSON.stringify ({
		action: "close",
	}));
});

$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			$('body').fadeOut();
			$.post('https://vrp_jobs/action', JSON.stringify({
				action: "close",
			}));
		}
	};
});