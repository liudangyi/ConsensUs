// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery.minicolors

$(document).ready(function() {
  $('#modal').modal()
  $('[data-modal=true]').click(function(e) {
    var url = $(this).attr('href')
    $.get(url).done(function(data) {
      $('#modal').html(data)
    })
    $('#modal').modal('open')
    return false
  })

  // why it does not work when put in html.erb in <script>
  $('.expand-toggle').click(function(e) {
    e.preventDefault();
    var notthis = $('.active').not(this);
    // notthis.find('.icon-minus').addClass('icon-plus').removeClass('icon-minus');
    notthis.toggleClass('active').next('.faqanswer').slideToggle(300);
    $(this).toggleClass('active').next().next().slideToggle("fast");
    // $(this).children('i').toggleClass('icon-plus icon-minus');
  });
})
