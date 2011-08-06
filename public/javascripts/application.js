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

//Hide resume details

  	$(".resume").find(".resume_subhead").next().hide().end().find(".resume_subhead").click(function(){
		$(this).next().slideToggle();
	});
	
//Twitter feed

	$("#twitterfeed").kstwitter('ksmithholbourn', 4);

})