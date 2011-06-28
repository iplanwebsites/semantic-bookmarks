/* 

*/

debug = true;

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
					this.title('favs');
					$('.popbox').removeClass('visible');
					
		});
  
    this.get('#/invite', function(context) {
					this.title('Invite');
					$('.popbox').removeClass('visible');
					$('.popbox.invitebox').addClass('visible');
					//$('.popbox.invitebox .biginput').focus();//Set focus on field
					$.scrollTo( '0', 400 );
		});
		
    this.get('#/login', function(context) {
					this.title('Login');
					$('.popbox').removeClass('visible');
					$('.popbox.loginbox').addClass('visible');
					$.scrollTo( '0', 400 );
		});
		
		this.get('#/features', function(context) {
					this.title('Login');
					$('.popbox').removeClass('visible');
					$('#features').addClass('active');
					$.scrollTo( '#features', 400 );
		});
		
/* //////////////////////////////////////////////
//// Form Put Routes
///////////////////////////////////////////////*/




//Login Form
	this.put('#/post/login', function(context) {
		//TODO JS validation here.
		// submit login + pass to the server.
		// write feedback to user (either error message, or log him in);
		alert('login: ' + this.params['login'] + ' & '+ this.params['pass']);
		//this.redirect('#/login/ok/'+this.params['login']);
    return false;
	});

    
});// end sammy defs

/* //////////////////////////////////////////////
//// Initialization
///////////////////////////////////////////////*/

    // start the application
 		sammy.run('#/');
		



		
			
/* //////////////////////////////////////////////
//// Binding Actions to DOM elements
///////////////////////////////////////////////*/
		
		


$('#bt_try_now').bind('click touch', function() {
		//sammy.setLocation('#/'); //doesn't populate the history stack correctly...
		$.scrollTo( 'header', 400 );
		return false;
});


$('.bt_fake_upload').bind('click touch', function() {
	$(this).siblings('input[type="file"]').trigger('click')
	//$('#real_upload').trigger('click');
});



//exit the feedback form on click
//TODO: propper exiting...
$('#feedback').bind('click touch', function() {
		sammy.setLocation('#/'); //doesn't populate the history stack correctly...
	});
}); // eo document ready.



















