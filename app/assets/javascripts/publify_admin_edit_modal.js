// Admin edit modal javascript manifest
//
//= require strftime
//
//= require_self

function update_permalink() {
  var permalinkText = $('#article_permalink').val().trim()
  $('#permalink').closest('.control-group').find('p strong').text(permalinkText);
}

function update_allow_comments() {
  var isChecked = $('#article_allow_comments').is(':checked');
  var allowCommentsText = isChecked
  ? $('#conversation-on').text()
  : $('#conversation-off').text();

  // Update the strong text with the status text from hidden spans
  $('#conversation').closest('.control-group').find('p strong').text(allowCommentsText);
}

function update_visibility() {
  var isVisible = $('#article_password').val().trim().length == 0;
  var visibilityText = isVisible
  ? $('#visibility-on').text()
  : $('#visibility-off').text();

  // Update the strong text with the status text from hidden spans
  $('#visibility').closest('.control-group').find('p strong').text(visibilityText);
}

function update_text_filter() {
  var selectedOptionText = $('#text_filter_name option:selected').text();

  // Update the strong text with the selected option text
  $('#text_filter').closest('.control-group').find('p strong').text(selectedOptionText);
}

function update_published_at() {
  var date = new Date($('#article_published_at').val());
  var format = $('#datetime-format').text();
  var formattedDate = strftime(format, date);

  // Update the strong text with the updated datetime
  $('#article_published_at').closest('.control-group').find('p strong').text(formattedDate);
}

// Set up the dynamic modal bindings
function initialize_edit_modal() {
  $('#article_permalink').change(update_permalink);
  $('#article_allow_comments').change(update_allow_comments);
  $('#text_filter_name').change(update_text_filter);
  $('#publish .btn a').click(update_published_at);
  $('#visibility .btn a').click(update_visibility);
}
