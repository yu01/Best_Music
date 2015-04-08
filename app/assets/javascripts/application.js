//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap.min

$(document).ready(function() {
  $(window).scroll(function() {
    var url = $('.pagination .next_page').attr('href');
    if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 900) {
      $('.pagination').text("");
      return $.getScript(url);
    }
  });
  return $(window).scroll();
});
