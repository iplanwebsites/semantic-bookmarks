/* 

*/

function throttle(fn, delay) {
  var timer = null;
  return function () {
    var context = this, args = arguments;
    clearTimeout(timer);
    timer = setTimeout(function () {
      fn.apply(context, args);
    }, delay);
  };
}



function cleanDomain(u){
    s = u;
    s = s.replace('https://www.', '');
    s = s.replace('http://www.', '');
    s = s.replace('https://', '');
    s = s.replace('http://', '');
    s = s.substr(0, s.indexOf('/'));
    return s;
    
}

function isUrl(s) {
	//This function has to be more liberal,
	// we want to let simple url entry work as well
	// ie. facebook.com, bit.ly, www.google.com, etc)
	var domain =/^([a-z0-9]([-a-z0-9]*[a-z0-9])?\\.)+((a[cdefgilmnoqrstuwxz]|aero|arpa)|(b[abdefghijmnorstvwyz]|biz)|(c[acdfghiklmnorsuvxyz]|cat|com|coop)|d[ejkmoz]|(e[ceghrstu]|edu)|f[ijkmor]|(g[abdefghilmnpqrstuwy]|gov)|h[kmnrtu]|(i[delmnoqrst]|info|int)|(j[emop]|jobs)|k[eghimnprwyz]|l[abcikrstuvy]|(m[acdghklmnopqrstuvwxyz]|mil|mobi|museum)|(n[acefgilopruz]|name|net)|(om|org)|(p[aefghklmnrstwy]|pro)|qa|r[eouw]|s[abcdeghijklmnortvyz]|(t[cdfghjklmnoprtvwz]|travel)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])$/i
	var fullUrl = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
	if(fullUrl.test(s) || domain.test(s)){
			return true
	}else{
		return false;
	}
}


$(document).ready(function() {
    

	/*
	On keypress,
		we can't add a URL directly once we detect something that looks like an URL.
		so we rather just "show" to the user that we recorganized this as a link:
		We add the class "is_url" to the text-field (so the text now appears blue+underlined)
	
	*/
    
    
    /*
    TODO: ovveride the form submit function in JS.
    Posting to a sammy function clear the fields, trigger a page refresh, etc...
    (not smooth now... )


    
    */
    
    
    

// initialize the application
    sammy = Sammy('#main', function() {
  // include a plugin
  //this.use('Mustache');
  this.use('Template');
  
  
    this.get('#/', function(context) {
            $.ajax({
              url: 'js/delicious.json', //won't work locally, be sure to run this unsing test server...
              dataType: 'json',
              success: function(items) {
                  //alert('yay');
                $.each(items, function(i, item) {
                  context.log(item.d, '-', item.t, '-', item.u);
                  //context.partial('templates/link.template');
                  context.render('templates/link.template', {item: item})
                                 .appendTo(context.$element());
                                 
                });
              }
            });
          });
  
          
    this.get('#/settings', function() {  
							 $('.activePage').removeClass('activePage show');
							 $('#settings').addClass('show activePage');
               $('#settings').addClass('show');

           });
  
    this.post('#/search', function(context) { 
        var key = this.params['q'];
        console.log('searching '+key);
        this.trigger('filterResults');
        return false;
      });
      
    this.post('#/cart', function(context) {
        this.log("I'm in a post route. Add me to your cart");
    });
            
      
    
});// end sammy defs


    // start the application

    sammy.run('#/');
    
    
    
    
    //bind an hashchange on the search-field change?
		
		
		$('#search_form').submit(function(event) {
			event.preventDefault(); //so the form doesn't submit.
			//var self = this;
			str = $('#q').val();
			if(isUrl(str)){
				// addUrl(cleanDomain(str));
				// we should  redirect to "#!/add/domain.com" so sammy.js routes can take over?
			}else{ //if not a valid url it's either keywords filtering, or an incomplete Url...
				// do a regular search.
				// we update the hash only on submit...
				// on keypress, we don't (it would really pollute the history stack...)
			//	sammy.redirect('#/search/'+str);
			}
		});
		
		
		$('#q').bind('keypress keyup change focus click', function() {
			
			//Unselect showed "modal pages", like settings, when someone fiddle with the txtfield.
			// $('.activePage').removeClass('activePage show');
			// instead: run the #/ page... so the history is preserved...
			// for complex search/filter?
			
			//if there's an active page...
			if($('.activePage').length > 0){
				//then se set back the URL to search.
				//the search function will clear any modal-pages.
			}
			
			
			var str = $(this).val();
			if( isUrl( str ) ) {	//check if it's a URL... //change style accordingly...
				$(this).parent().addClass('is_url'); //we attach a special class to the form element
			}else{
				$(this).parent().removeClass('is_url');
			}
	
			//this is the part we don't want to execute too often
			throttle(function (event) {
        //update search feed.
        this.trigger('filterResults');
    	}, 250);

});
    
    
});//document ready...



















