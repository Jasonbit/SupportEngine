var SupportEngine = {};

SupportEngine.Query = function(element, url) {
  this.element = element;
  this.url     = url;
  this.timer   = null;
  this.bind();
};

SupportEngine.Query.prototype = {
  bind: function() {
    this.element.on('keyup', this.onInputKeyUp.bind(this));
  },

  onInputKeyUp: function(event) {
    if (this.timer !== null) { clearTimeout(this.timer); }
    if (this.value().length >= 3) {
      this.timer = setTimeout(this.query.bind(this), 1000);
    }
  },

  query: function() {
    this.xhr = $.getJSON(this.url, { q: this.value() });
    this.xhr.done(this.done);
    this.xhr.fail(this.fail);
  },

  done: function(data) {
    var tickets = $(".se-similar-question").html("");

    for (var x = 0; x < data.tickets.length; x++) {
      var ticket = data.tickets[x];
      var link = $("<a>").html(ticket.title).attr("href", ticket.url);
      tickets.append($("<li>").append(link));
    }
  },

  value: function() { return this.element.val(); }
};

SupportEngine.Widget = function(element_id) {
  if (element_id !== undefined) {
    this.element = $(element_id);
  } else {
    this.element = $(".se-widget");
  }
  this.form       = this.element.find("form");
  this.queryField = this.element.find(".se-search-field");
  this.query      = new SupportEngine.Query(this.queryField, this.form.attr("action"));
};

SupportEngine.Widget.prototype = {
  bind: function() {
  }
};


$(function() {
  if ($('.se-widget').length == 1) {
    new SupportEngine.Widget();
  }
});
