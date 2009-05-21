$(function(){
	
	/*
	* the event handler for a "div.set div.photo" click
	*/
	function photoClick(){
		var img = $('<img class="photo" />');
		img.attr('src', $('img', this).attr('alt'));
		$('#photoBucket').html(img);
	}
	
	/*
	* gets called for each new search
	* sets up the pagination options
	*/
	function paginate(total_pages, per_page, callback){
		pagination_opts = {
          callback : callback,
          items_per_page : per_page,
          num_display_entries : 4,
          num_edge_entries : 1
        }
        $("#Pagination").pagination(total_pages, pagination_opts);
	}
	
	/* replaces the container html with the set (div.set)
	* and applies behaviors to the .photo items
	*/
	function insertPhotoSetAndApplyBehaviors(container, data){
		container.html(data);
		$('div.photoItem', container).click(photoClick);
	}
	
	/* This gets called after a successful response has been
	* returned from the flickr controller "service".
	* It creates a new container div (.set) -- this is done so each set can fade-in/out.
	* (if a div.set already exists, it is faded out).
	* insertPhotoSetAndApplyBehaviors is called and passed the new div.set
	*/
	function applyResponse(data){
		var container = $('#photoSets');
		var current_set = $('div.photoSet', container);
		if(current_set.length > 0){
			current_set.fadeOut('medium', function(){
				insertPhotoSetAndApplyBehaviors(container, data);
			})
		}else{
			insertPhotoSetAndApplyBehaviors(container, data);
		}
	}
	
	/*
	* sends the request to the /flickr/photos controller.
	* the page is the page number (used by the flickr/photos action)
	* the "callback" gets passed the data from the flickr/photos action
	*/
	function photoSearch(page, callback){
		$('#loadIndicator').show();
		$.get('/flickr/photos', {q:$('#q').val(), page:page, username : $('#username').val()}, function(data){
			callback(data);
			$('#loadIndicator').hide();
		})
	}
	
	/*
	* the response is the HTML result of the flickr/photos action.
	*/
	var paginatingSearchCallback = function(response){
		var d = $(response);
		var total_pages = $('#total', d).html();
		var per_page = $('#per_page', d).html();
		paginate(total_pages, per_page, function(page_index, container){
			if(page_index == 0){
				applyResponse(response);
			}else{
				photoSearch(page_index+1, applyResponse);
			}
		});
	}
	
	/*
	* The main search function
	*/
	function newSearch(){
		photoSearch(1, paginatingSearchCallback);
	}
	
	$('#search form').submit(function(){
		newSearch();
		return false;
	});
	
	$('#loadIndicator').hide();
	
	/* when the page loads, fire off a search */
	newSearch();
	
});