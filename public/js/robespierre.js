refreshTweets = function() {
	$("#conteneur_tweet").load("/fresh_tweets", function() {
		setTimeout(refreshTweets,20000) 
	})
}

$(document).ready(function(){

	refreshTweets()

	$('.remove-my-song').on('click', function(event) {
		console.log('into remove my song')
		event.preventDefault()
		var name = $(this).prev('.my-song').text()
		$.post('/remove_track', {name: name})
		$(this).parent().remove()
	})
});
