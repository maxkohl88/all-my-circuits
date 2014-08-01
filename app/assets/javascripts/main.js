$(document).ready(function() {

  //hover effect on main page login button
  $('.sign-up-button').on('mouseenter', function(){
    $(this).css('background-color', 'rgba(160, 228, 255, 0.91)');
  });

  $('.sign-up-button').on('mouseleave', function(){
    $(this).css('background-color', 'black');
  });

  function introAnim() {
    $('#circuits-header').slideToggle(1800);
    $('#circuits-description-left').show();
    $('#circuits-description-left').animate({left: '36%'}, 1500);
    $('#circuits-description-right').show();
    $('#circuits-description-right').animate({right: '32.6%'}, 1500);
    $('#sign-up-button-container').show();
    $('#sign-up-button-container').animate({top: '45%'}, 1500);
  }

  introAnim();

  // search for users by attributes
  $('#search-form').submit(function(event) {
    runSearch(event);
  });

  // hide sliding drawers
  $('.extended-profile').hide();

  // buttons for sliding drawers
  $('.search-results').on('click', '.drawer-cta', function() {
    $(this).parent().parent().children('.result-preview').children('.extended-profile').slideToggle(700);
  });

  // buttons for likes
  $('.search-results').on('click', '.like-button', function(event) {
    findOrCreateChat(event);
  });

  // buttons for unlikes
  $('.waiting-for-like-container').on('click', '.unlike-button', function(event) {
    unlikeUpdate(event);
  });

  // block user from matches manager
  $('.active-matches-container').on('click', '.block-button', function(event) {
    blockUpdate(event);
  });

  $('#chat-display').hide();
  $('.chat-text-box').hide();
  $('#close-chat-container').hide();
  // get the messages for a particular chat (in order to show chat)
  $('.active-conversation-list').on('click', '.conversation-preview-contents', function(event) {
    $('.chat-content').empty();
    getMsgs(event);
  });

  $('#chat-submit').submit(function(event) {
    sendMsg(event);
  });

  $('#close-chat-button').click(function(){
    $('.conversation-preview-container').animate({width: '75%'}, 500);
    $('.conversation-preview').children('.conversation-preview-contents').children('li').show();
    $('.active-conversation-list').children('.conversation-preview').animate({width: '100%', 'margin-bottom': '30px'}, 500);
    $('#chat-display').hide();
    $('.chat-text-box').hide();
    $('#conversation-window-container').animate({width: '25%'}, 500);
    $('#chat-window').animate({width: '12%'}, 500);
    $('#close-chat-container').hide();
    $('.active-conversation-list').animate({'margin-left': '150px'}, 500);
  });

});

// get all messages to display in a chat
var getMsgs = function(event) {
  event.preventDefault();
  var chatId = $(event.target).parent().attr('data');
  $.ajax({
    type: 'get',
    datatype: 'json',
    url: 'http://localhost:3000/chats/' + chatId + '/messages'
  })
  .done(function(data) {
    console.log('yooooyo');
    // chat window animations
    $('.active-conversation-list').animate({'margin-left': '0px'}, 500);
    $('.conversation-preview-container').animate({width: '10%'}, 500);
    $('.conversation-preview').children('.conversation-preview-contents').children('li').hide();
    $('.active-conversation-list').children('.conversation-preview').animate({width: '20%', 'margin-bottom': '0px'}, 500);
    $('#chat-display').show();
    $('.chat-text-box').show();
    $('#conversation-window-container').animate({width: '80%'}, 500);
    $('#chat-window').animate({width: '100%'}, 500);
    $('.conversation-page-header').text();
    $('#close-chat-container').show();

    // bring out the chat body
    // append handlebar template for chat msgs
    $('.chat-text-box').attr('chat_id', data[0].chat_id);
    $('.chat-content').append(HandlebarsTemplates.buildChat(data));
  });
};

// send a message to a chat
var sendMsg = function(event) {
  event.preventDefault();
  var chatId = $(event.target).parent().parent().attr('chat_id');
  var content = $(event.target).children('.new-message-field').val();
  $.ajax({
    type: 'post',
    datatype: 'json',
    url: 'http://localhost:3000/chats/' + chatId + '/messages',
    data: {message: {content: content, chat_id: chatId}}
  })
  .done(function(data) {
    // append msg to chat body
    $('.chat-content').append(HandlebarsTemplates.buildChat([data]));
  });
};

// update the chat, blocked = true
// maybe add an 'Are you sure?' (no un-blocking)
var blockUpdate = function(event) {
  event.preventDefault();
  var chatId = $(event.target).attr('data');
  $.ajax({
    type: 'patch',
    datatype: 'json',
    data: {chat: {blocked: true}},
    url: 'http://localhost:3000/chats/' + chatId
  })
  .done(function() {
    $(event.target).closest('.match-result').remove();
  });
};
// user will be u1 if they are unliking
var unlikeUpdate = function(event) {
  event.preventDefault();
  var chatId = $(event.target).attr('data');
  $.ajax({
    type: 'delete',
    datatype: 'json',
    url: 'http://localhost:3000/chats/' + chatId,
  })
  .done(function() {
    $(event.target).closest('.match-result').remove();
  });
};

// on clicking 'like', successfully does find_or_create
// BUT registers an internal server error
var findOrCreateChat = function(event) {
  event.preventDefault();
  var that = $(event.target);
  var being_liked = that.closest('.result-preview').attr('user_id');

  $.ajax({
    type: 'post',
    data: {chat: {u2: being_liked}},
    url: 'http://localhost:3000/sendlike',
    datatype: 'json'
  }).done(function() {
    $(that).addClass('liked-button');
    $(that).text('Liked!');
  });

};

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
    $('.search-results').empty();
    $('.search-results').append(HandlebarsTemplates.search_index(data));
    $('.extended-profile').hide();
  })
  .fail(function() {
    console.log('total failure');
  });
};
