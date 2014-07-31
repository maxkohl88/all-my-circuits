$(document).ready(defaultSearch);
$(document).on('page:load', defaultSearch);

function defaultSearch() {
  if ($('.search-results').length > 0 ) {
    $.ajax({
      url: "http://localhost:3000/users",
      type: 'GET',
      dataType: 'json'
    })
    .done(function(data) {
      $('.search-results').empty();
      $('.search-results').append(HandlebarsTemplates.search_index(data));
      $('.extended-profile').hide();
    })
    .fail(function() {
      console.log('total failure');
    });
  }
}
