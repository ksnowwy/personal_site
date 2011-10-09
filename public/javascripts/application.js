$(document).ready(function() {

//Show hide for month menu

  	$(".month_names").find(".month_list").hide().end().find(".month_name_link").click(function(){
		$(this).next().slideToggle();
	});

//Form error indicators

	$(".field_with_errors").find("input").focus(function(){
		$(this).parent().removeClass().addClass("fixed_field");
	});
	
//Fadeout flash

	$('.flash').delay(3000).fadeOut(2000, function() {
    // Animation complete.
  	});
	
//Twitter feed

	$("#twitterfeed").kstwitter('ksmithholbourn', 4);
	
//Draggable

	$('.draggable').draggable( {
	    helper: picHelper
	});
	$('#droppable').droppable( {
		drop: handleDropEvent
	});
	
//Current page button

	var url = window.location.pathname;
	if(url != "/") 
	{
	        urlRegExp = new RegExp(url.replace(/\/$/,'') + "$");
	        $('.site_header nav ul li a').each(function()
			{
	            if(urlRegExp.test(this.href.replace(/\/$/,'')))
				{
	                $(this).addClass('active-link');
	            }
	        });
	}
	else if(url == "/") {
		$('.home-link').addClass('active-link');

	}
});

$(window).load(function() {

//Min-height for posts with images

	$('.article_body').has('img').css('min-height', ($('.article_body').find('img').height()));
	

	
})

//Image selection

function picHelper( event ) {
  return '<div id="draggable-helper">Drop me where you want the image!</div>';
}

function handleDropEvent( event, ui ) {
  var currentText = $('#droppable').val();
  var draggable = ui.draggable;
  $(draggable).find(':checkbox').prop("checked", true);
  $('#droppable').val(currentText + draggable.attr('id'));
}