---
---
$(document).ready(function() {
  var chapter = $('.container').data('chapter');

  if (chapter) {
    // We're in a chapter
    var progress = chapter / {{ site.chapters.size }};
    $('.tutorial_nav .progress_bar').css('width', progress * 100 + '%');
  } else {
    $('.tutorial_nav .progress').css('display', 'none');
  }

  // Setting padding top here since the nav bar will change height depending on
  // whether or not the progress bar is visible, so we also need to change the
  // padding-top so that the content sits nicely below the nav bar.
  $('.content').css('padding-top', $('.tutorial_nav').height());
});
