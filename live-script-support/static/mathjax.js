MathJax.Hub.Config({
    tex2jax: {
        inlineMath: [ ['$','$'], ["\\(","\\)"] ],
        displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
        processEscapes: true
    }
});
jQuery(document).ready(function($) {
  $('.rtcContent span').each(function() {
    var texencoding = $(this).attr("texencoding");
    var mathmlencoding =  $(this).attr("mathmlencoding");
    if(typeof texencoding !== typeof undefined){
      $(this).css('font-size', 'small');
      $(this).css('vertical-align', 'inherit');
    }else if (typeof mathmlencoding !== typeof undefined && mathmlencoding.includes('display="inline"')){
      $(this).css('vertical-align', 'inherit');
      $(this).css('font-size', 'small');
    }
  });
})
