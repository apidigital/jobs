// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_for_destroy(element) {
	$(element).next('.should_destroy').value = 1;
	$(element).up('.question').hide();
}

// For the floating window of Redbox
if (document.recalc && document.body.attachEvent) { 
  RB_window.style.setExpression("top", "document.body.scrollTop + 150");
//  RB_window.style.setExpression("left", "document.body.scrollLeft + 150");
  document.body.onscroll=function(){document.recalc(true)}; 
} 