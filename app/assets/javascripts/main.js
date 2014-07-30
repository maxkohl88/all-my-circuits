$(document).ready(function() {

  $('#search-form').submit(function(event) {
    runSearch(event);
  });


});

var runSearch = function(event) {
  event.preventDefault();

  var queryString = "?";
  var queryTerm;

  queryTerm = $('#human_language').val();
  if (queryTerm !== "") {
    queryString += 'human_language=' + queryTerm + '&';
  }

  queryTerm = $('#zip').val();
  if (queryTerm !== "") {
    queryString += 'zip=' + queryTerm + '&';
  }

  queryTerm = $('#game_genre').val();
  if (queryTerm !== "") {
    queryString += 'game_genre=' + queryTerm + '&';
  }

  queryTerm = $('#music_genre').val();
  if (queryTerm !== "") {
    queryString += 'music_genre=' + queryTerm + '&';
  }

  queryTerm = $('#movie_genre').val();
  if (queryTerm !== "") {
    queryString += 'movie_genre=' + queryTerm + '&';
  }

  queryTerm = $('#min_height').val();
  if (queryTerm === "") { queryTerm = 48; }
  queryString += 'min_height=' + queryTerm + '&';

  queryTerm = $('#max_height').val();
  if (queryTerm === "") { queryTerm = 96; }
  queryString += 'max_height=' + queryTerm + '&';

  queryTerm = $('#min_age').val();
  if (queryTerm === "") { queryTerm = 18; }
  queryString += 'min_age=' + queryTerm + '&';

  queryTerm = $('#max_age').val();
  if (queryTerm === "") { queryTerm = 75; }
  queryString += 'max_age=' + queryTerm + '&';

  $.ajax({
    url: "http://localhost:3000/users" + queryString,
    type: 'GET',
    dataType: 'json'
  })
  .done(function(data) {

    $('#results').empty();
    $('#results').append(HandlebarsTemplates.search_index(data));

  })
  .fail(function() {
    console.log('total failure');
  });
};

/* clear all results on search page,
          handlebar and append new results */
