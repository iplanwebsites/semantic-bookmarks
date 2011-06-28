/* 

*/

debug = true;

/* //////////////////////////////////////////////
//// Functions (toolkit)
///////////////////////////////////////////////*/

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

/* //////////////////////////////////////////////
//// Sammy JS init
///////////////////////////////////////////////*/

$(document).ready(function() {
    
    
// initialize the application
sammy = Sammy('body', function() {
  this.use('Template');
	this.use('Storage');
	this.use('Session');
	this.use('OAuth2');
	this.use('Title');
	this.use(Sammy.JSON);
  
	this.oauthorize = "/oauth/authorize"; //the Oauth2 url - Sinatra?
	
	// HOME
    this.get('#/', function(context) {
			// alert("sam");
			//Load preferences
					this.title('favs');
					$('#q').focus();//Set focus on field
					$('.activePage').removeClass('activePage show'); //removes the selected page...

					//Todo: only load Ajax if it's not already there...
					this.trigger('load-ajax', {url: '/api/v1/delicious/feed'}); //default path: '/api/v1/delicious/feed'
					this.trigger('show-page', {page: 'links'});
		}); //end "get #/"
  
//Delicious User feed
this.get('#/delicious/:user', function(context) {
			$('.activePage').removeClass('activePage show'); //removes the selected page...
			this.title('Delicious @'+this.params['user']);
			sammy.trigger('show-page', {page: 'links'});
			//Todo: only load Ajax if it's not already there...
			this.trigger('load-ajax', {url: '/api/v1/delicious/feed/'+this.params['user'] }); //'/api/v1/delicious/feed'
			// this.trigger('show-page', {page: 'links'});
}); 

/* //////////////////////////////////////////////
//// Form Put Routes
///////////////////////////////////////////////*/



// Main field submit
this.put('#/post/q', function(context) {
	sammy.trigger('show-page', {page: 'links'});
	str = this.params['q'];
	if( isUrl( str ) ) {	//check if it's a URL... //change style accordingly...
		sammy.trigger('add-url', {url: str});//add URL
		this.title('added: "'+str+'"');
	}else{
		//TODO improve parsing logic (if there's a semantic keyword, use it!)
		this.title('filter: '+str);
		sammy.trigger('filter-item');
	}
	return false; //event.preventDefault(); 
});


	//delicious user (test form)
	this.put('#/post/del', function() {
			str = this.params['user']; //delicious login...
			var path = '#/delicious/'+str;
			this.redirect(path);
			return false;
		});

//Login Form
	this.put('#/post/login', function(context) {
		//TODO JS validation here.
		// submit login + pass to the server.
		// write feedback to user (either error message, or log him in);
		alert('login: ' + this.params['login'] + ' & '+ this.params['pass']);
		//this.redirect('#/login/ok/'+this.params['login']);
    return false;
	});


/* //////////////////////////////////////////////
//// AUTHentification  (oAuth) - missing a provider...
///////////////////////////////////////////////*/
 
 // The quick & easy way
 	//this.requireOAuth();
 // Specific path
 	// this.requireOAuth("/private");
 // Filter you can apply to specific URLs
 	//this.before(function(context) { return context.requireOAuth(); })
 // Apply to specific request
 this.get("/private", function(context) {
   this.requireOAuth(function() {
			alert("you are logged in my friend!");
     // Do something
   });
 });

// Sign in/sign out.
this.bind("oauth.connected", function() { $("#signin").hide() });
this.bind("oauth.disconnected", function() { $("#signin").show() });

// Handle access denied and other errors
this.bind("oauth.denied", function(evt, error) {
  this.partial("admin/views/no_access.tmpl", { error: error.message });
});

// Sign out.
this.get("#/signout", function(context) {
  context.loseAccessToken();
  context.redirect("#/");
});


/* //////////////////////////////////////////////
//// PAGES (modal)
///////////////////////////////////////////////*/
    //Settings
    this.get('#/settings', function() {  
							this.title('Settings');
							/* $('.activePage').removeClass('activePage show');
							 $('#settings').addClass('show activePage');
               $('#settings').addClass('show'); */
							this.trigger('show-page', {page: 'settings'});
    });

		//Feedback
    this.get('#/feedback', function() { 
	 						this.title('Feedback');
							this.trigger('show-page', {page: 'feedback'});
    });


		//EVENT: Load Ajax
		this.bind('load-ajax', function(e, data) {
						var context=this;
						$.ajax({
	              url: data['url'], 
                  data: { count: 20 },
	              dataType: 'json',
	              success: function(items) {
	                $.each(items, function(i, item) {
	                  // context.log(item.d, '-', item.t, '-', item.u);
	                  //context.partial('templates/link.template');
										
										
										context.artistpage = context.$element('#page_artist');
										$(context.linkContainer).html('');
	                  context.render('templates/link.template', {item: item})
	                                 .appendTo(context.linkContainer).then(function(content) {
																			context.trigger('filter-item'); //if field is already populated (page refresh)
																	});
	                });
	              }
	            }); //end AJax load.
		  });
	
	
			this.bind('reload-server', function(e, data) {
					//	var context=this;
						this.log('contacting server');
		  });
		
			//EVENT: show page.
			this.bind('show-page', function(e, data) {
						var context=this;
						pageId = data['page'];
						if((pageId =='links') && ($('.activePage').attr('id') != "links")){
							 //sammy.setLocation('#/');
							// this was too heavy, we should just swap active page, not redirect
						}
						
						if(pageId != $('.activePage').attr('id')){ //if we want a different page than the curent one.
						 $('.activePage').removeClass('activePage show');
						 $('#'+pageId).addClass('show activePage');
             $('#'+pageId).addClass('show');
						}
						
		  });
		
			//EVENT: filter item.
			this.bind('filter-item', function(e, data) {
					var context=this;
					str = $('#q').val();
					
					//decorate URL
					if( isUrl( str ) ) {	//check if it's a URL... //change style accordingly...
						$(this).parent().addClass('is_url'); //we attach a special class to the form element
					}else{
						$(this).parent().removeClass('is_url');
					}
					
					if(str.length == 0){
						$('#search_form .clear-val').removeClass('show');
					}else{
						$('#search_form .clear-val').addClass('show');
					}

					//TODO: using another throttle technique, we can contact the server...
										
					//if this.countain (the text...), maybe use a regEx?
					$("div.item:not(:contains('"+str+"'))").addClass('out');
					$("div.item:contains('"+str+"')").removeClass('out');

			}); // /filter-items
			
			
    
});// end sammy defs

/* //////////////////////////////////////////////
//// Initialization
///////////////////////////////////////////////*/

    // start the application
 		sammy.run('#/');
		

		//Init Cookie
		sammy.cookie = new Sammy.Store({name: 'prefs', type: 'cookie'});
		var zoom = sammy.cookie.get('zoom_level');
		if(zoom != undefined){
			$('#zoom_level').val(zoom);
			$('body').addClass('zoom'+zoom);
		}
		
			
/* //////////////////////////////////////////////
//// Binding Actions to DOM elements
///////////////////////////////////////////////*/
		
		//Zoom-Level slider
		if (!Modernizr.inputtypes.range) {
				$('#zoom_level').hide(0);
		  	// no native support for type=number fields
		  	// maybe try Dojo or some other JavaScript framework
		}else{
			$('#zoom_level').change(function(){
				var val = $(this).val();
				var className = 'zoom' + val;
				$('body').removeClass('zoom1 zoom2 zoom3 zoom4 zoom5 zoom6 zoom7')
				$('body').addClass(className);
				sammy.cookie.set('zoom_level', val); //and save it to the cookie...
			});
		}
		
		
// Button Erase search field
		$('#search_form .clear-val').bind('click', function() {
				$('#q').val('').focus();
				sammy.trigger('filter-item');
		});


//Keypress txt-field
$('#q').bind('keypress keyup change focus click', function() {
	sammy.trigger('filter-item');
	sammy.trigger('show-page', {page: 'links'});
			throttle(function (event) {
				//TODO: contact server here?
    	}, 150);
});

//logo click (clear the field, redirect to home.)
$('#logo').bind('click touch', function() {
	$('#q').val('').focus();//clear the search field
	sammy.setLocation('#/');
	sammy.trigger('show-page', {page: 'links'});
	sammy.setTitle('favs'); //just in case we're already on the main view...
	return false;
});

//Settings page, instructions menu
$('#browser_menu').bind('change', function() {
	var val = $('#browser_menu').val();
	$('.import_instruction.open').removeClass('open');//remove open class to old element...
	$('.import_instruction.'+val).addClass('open');//Add open class to new one
});


//Settings page, instructions menu
$('#promo_header .box').hover(
  function () {
		$('#promo_header .box').addClass("not_hover");
		$(this).removeClass("not_hover");
    $(this).addClass("hover");
  },
  function () {
    $(this).removeClass("hover");
		$('#promo_header .box').removeClass("not_hover");
  }
);


$('#bt_try_now').bind('click touch', function() {
		//sammy.setLocation('#/'); //doesn't populate the history stack correctly...
		$.scrollTo( 'header', 400 );
		return false;
});


$('.bt_fake_upload').bind('click touch', function() {
	$(this).siblings('input[type="file"]').trigger('click')
	//$('#real_upload').trigger('click');
});


$('#home_file_upload').bind('change', function() {
	alert('ok! we submit the form (file) to a sammy route, then sinatra API, and display progress...');
// TODO: parent form. submit...
//map a corersponding sammy put route...

});


//exit the feedback form on click
//TODO: propper exiting...
$('#feedback').bind('click touch', function() {
		sammy.setLocation('#/'); //doesn't populate the history stack correctly...
	});
}); // eo document ready.



















