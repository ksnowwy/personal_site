$(document).ready(function() {

//Show hide for month menu

  	$(".month_names").find(".month_list").hide().end().find(".month_name_link").click(function(){
		$(this).next().slideToggle();
	});

//Form error indicators

	$(".field_with_errors").find("input").focus(function(){
		$(this).parent().removeClass();
	});
	
//Fadeout flash

	$('.flash').delay(3000).fadeOut(2000, function() {
    // Animation complete.
  	});
	
//Twitter feed

	$("#twitterfeed").kstwitter('ksmithholbourn', 4);
	
//Min-height for posts with images

	$('.article_body').has('img').css('min-height', ($('.article_body').has('img').height()+30));

})