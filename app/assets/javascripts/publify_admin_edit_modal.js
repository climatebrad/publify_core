// Admin edit modal javascript manifest
//
//= require strftime
//
//= require_self

var contentClass;

function update_permalink() {
  var permalinkText = $(`#${contentClass}_permalink`).val().trim();
  $('#permalink').closest('.control-group').find('p strong').text(permalinkText);
}

function update_allow_comments() {
  var isChecked = $(`#${contentClass}_allow_comments`).is(':checked');
  var allowCommentsText = isChecked
  ? $('#conversation-on').text()
  : $('#conversation-off').text();

  // Update the strong text with the status text from hidden spans
  $('#conversation').closest('.control-group').find('p strong').text(allowCommentsText);
}

function update_publish_status() {
  var isChecked = $(`#${contentClass}_publish`).is(':checked');

  var initialState = $(`#${contentClass}_initial_state`).val();

  var statusText, submitText, submitAction;

  if (isChecked) {
    var publishedAtValue = $(`#${contentClass}_published_at`).val().trim();
    var publishedAtDate = publishedAtValue ? new Date(publishedAtValue) : null;
    var now = new Date();

    // Determine the status to display based on published at datetime
    if (publishedAtDate && publishedAtDate <= now) {
      submitAction = 'publish';
      statusText = $('#status-published').text();
      submitText = $('#submit-publish').text();
    } else {
      submitAction = 'publish';
      statusText = $('#status-publication_pending').text();
      submitText = $('#submit-publish').text();
    }
  } else {
    if (initialState === 'published') {
      submitAction = 'withdraw';
      statusText = $('#status-withdrawn').text();
      submitText = $('#submit-withdraw').text();
    } else {
      submitAction = 'draft';
      statusText = $('#status-draft').text();
      submitText = $('#submit-save_draft').text();
    }
  }

  // update the strong text with the status text from hidden spans
  $('#status').closest('.control-group').find('p strong').text(statusText);
  // update submit button value
  $('#modal-submit').val(submitText);
  $('#submit-action').val(submitAction);
}

function update_visibility() {
  var isVisible = $(`#${contentClass}_password`).val().trim().length == 0;
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
  var date = new Date($(`#${contentClass}_published_at`).val());
  var format = $('#datetime-format').text();
  // workaround: strftime parser can't handle '%HhM'
  format = format.replace('%Hh%M', '%H:h%M');
  var formattedDate = strftime(format, date);
  formattedDate = formattedDate.replace(':h', 'h');
  // Update the strong text with the updated datetime
  $(`#${contentClass}_published_at`).closest('.control-group').find('p strong').text(formattedDate);
}


function update_modal_published_at() {
  // for events and hearings
  // Get the date and time values from the form
  const date = $(`#${contentClass}_date`).val();
  const time = $(`#${contentClass}_time`).val();

  // Check if both date and time are set
  if (date && time) {
    // Combine date and time into a datetime string
    const dateTime = `${date} ${time}`;

    // Set the value of the datetime field in the modal
    $(`#${contentClass}_published_at`).val(dateTime);

    // Update the display of the datetime
    update_published_at();
  }
}

// Set up the dynamic modal bindings
function initialize_edit_modal() {
  contentClass = $('#content_class').val();
  $(`#${contentClass}_permalink`).change(update_permalink);
  $(`#${contentClass}_allow_comments`).change(update_allow_comments);
  $(`#${contentClass}_publish`).change(update_publish_status);
  $('#text_filter_name').change(update_text_filter);

  $(`#${contentClass}_date, #${contentClass}_time`).on('change', function () {
    update_modal_published_at();
  });

  $('#publish .btn a').click(function() {
    update_published_at();
    update_publish_status();
  });
  $('#visibility .btn a').click(update_visibility);

}
