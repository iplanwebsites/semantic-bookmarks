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


$(document).ready(function() {
    

// initialize the application
    sammy = Sammy('#main', function() {
  // include a plugin
  //this.use('Mustache');
  this.use('Template');
  
  
    this.get('#/', function(context) {
            $.ajax({
              url: 'js/delicious.json',
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
               alert('settings');
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
    
    
    
    
    //bind an hashchange on the search-field change.
    $('#q').keypress(throttle(function (event) {
        //update search feed.
        this.trigger('filterResults');
    }, 250));
    
    
});//document ready...



















