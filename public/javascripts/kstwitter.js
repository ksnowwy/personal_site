function relative_time(time_value) {
  var values = time_value.split(" ");
  time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
  var parsed_date = Date.parse(time_value);
  var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
  var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
  delta = delta + (relative_to.getTimezoneOffset() * 60);

  if (delta < 60) {
    return 'less than a minute ago';
  } else if(delta < 120) {
    return 'about a minute ago';
  } else if(delta < (60*60)) {
    return (parseInt(delta / 60)).toString() + ' minutes ago';
  } else if(delta < (120*60)) {
    return 'about an hour ago';
  } else if(delta < (24*60*60)) {
    return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
  } else if(delta < (48*60*60)) {
    return '1 day ago';
  } else {
    return (parseInt(delta / 86400)).toString() + ' days ago';
  }
}


(function( $ ){

  $.fn.kstwitter = function( username, tweetnumber ) {

  	  return this.each(function() {
  	  		  var $this = $(this);

		  $(".jsoff").css("display","none"); //hide the message about the twitter feed if JavaScript is on
		  
		  if ( username && tweetnumber ) {
			  
			  var settings = {count: tweetnumber};
			  
			  var url = "https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name="+username+"&count="+settings.count;
			alert(url);
			  
			  $.getJSON(url,
				  
				  function(data) {
					  
					  $.each(data, function( i, item ) {
					  		  var tweet = item.text;
					  		  var date = item.created_at;
					  		  var cleandate = relative_time(date);
					  		  
					  		  tweet = tweet.replace(/http:\/\/\S+/g,'<a href="$&" target="_blank">$&</a>');
						$this.append("<p><span class='username'><a href='http://twitter.com/"+username+"'>"+username+": </a></span>"+tweet.toString()+" <span class='tweettime'>"+cleandate.toString()+"</span></p>");
					
					  });
				  });
			  
		  } else {
			  console.debug("The Twitter plugin needs a username and a number of tweets to display.");
		  }
  	  
      });

  };
})( jQuery );