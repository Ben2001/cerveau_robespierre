refreshTweets = function() {
	$("#conteneur_tweet").load("/fresh_tweets", function() {
		setTimeout(refreshTweets,20000) 
	})
}

$(document).ready(function(){

	refreshTweets()

	$("#my-tracks").sortable({
		axis: "y",
		update: function() {
			var tracks = []
			$(".my-playlist .my-song").each(function(){
				tracks.push({title: $(this).text(), mp3: $(this).data('lien')})
			})
			$.post("/sort_url", {'tracks': tracks}
				)
		}
	});

	$('.remove-my-song').on('click', function(event) {
		console.log('into remove my song')
		event.preventDefault()
		var name = $(this).prev('.my-song').text()
		$.post('/remove_track', {name: name})
		$(this).parent().remove()
	})
});