$(document).on('turbolinks:load ready', function(){
  $('.dropdown-toggle').dropdown();
  $('[data-toggle="tooltip"]').tooltip(); 
  //$('.jquery_date').datepicker({dateFormat: 'dd-mm-yy',changeMonth: true, changeYear: true});
  $('.jquery_date').datepicker({format: 'yyyy-mm-dd',autoclose: true, endDate: "<%=Date.today%>" });
  bootstrapConfirm();
  loadSpinner();
  scrolToTop();
  submitRefresh();
});


function submitRefresh(){
  $('.js_custom_refresh').click(function(){
    form = $(this).data('form');
    $.ajax({
      type : "GET",
      url : $(this).data('url'),
      dataType : "script",
      data : $('#'+form).serialize()
    })
  });
}

function scrolToTop(){ 

  $(window).scroll(function() {
    if ($(this).scrollTop()) {
        $('#myBtn').fadeIn();
    } else {
        $('#myBtn').fadeOut();
    }
  });
  
  $(document).on('click','#myBtn',function (event) {
   $("html, body").animate({scrollTop: 0}, 100);
     event.preventDefault();
  });
}

function loadSpinner(){

  $(document).ajaxStart(function(){
    $("#spinnerModal").modal();
  });

  $(document).ajaxComplete(function(){
    $("#spinnerModal").modal('hide');
  });

  $(document).ajaxError(function(){
    $("#spinnerModal").modal('hide');
  });  
}

 
function bootstrapConfirm(){
  $('.bootstrap_confirm').click(function(){
    url = $(this).data('url');
    confirm_msg = $(this).data('confirmmessage');
    bootbox.confirm(confirm_msg,function(result){
      if(result)
         {
          $.ajax({
          type : 'GET',
          url : url,
          dataType : 'script'   
          });
         }
    });
  });
}


