
$(function() {
  console.log("hello");
  $(document).on("click", ".se-table tr td", function(event) {
    var element = event.currentTarget;
    var tr = $(element).parent();
    var link = tr.find("a");

    window.location =  link.attr("href");
  });
});
