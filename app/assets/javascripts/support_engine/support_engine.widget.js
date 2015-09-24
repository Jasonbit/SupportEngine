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

    if (data.tickets.length > 0) {
      tickets.removeClass("se-hidden");
      for (var x = 0; x < data.tickets.length; x++) {
        var ticket = data.tickets[x];
        var link = $("<a>").html(ticket.title).attr("href", ticket.url);
        tickets.append($("<li>").append(link));
      }
    } else {
      tickets.addClass("se-hidden");
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
  this.toggler    = new SupportEngine.Toggler();
  this.next       = this.element.find(".se-btn-next");
  this.bind();
};

SupportEngine.Widget.prototype = {
  bind: function() {
    this.next.on("click", this.showForm.bind(this));
    this.form.on("submit", this.submit.bind(this));
  },

  showForm: function(event) {
    $(".se-other-fields").removeClass("se-hidden");
    this.next.addClass("se-hidden");
  },

  submit: function(event) {
    var formData = this.form.serialize();

    $.ajax({ type: 'POST',   url:      this.form.attr("action"),
             data: formData, dataType: 'json',  encode : true })
    .done(this.success.bind(this))
    .fail(this.fail.bind(this));

    event.preventDefault();
  },

  success: function(data) {
    var message = data.message;
    this.form.prepend($("<div>").addClass("se-success").html(message));

    setTimeout(function() {
      $(".se-success").remove();
      this.form.get(0).reset();
      this.toggler.toggle();
    }.bind(this), 500);
  },

  fail: function(data) {
    var json = $.parseJSON(data.responseText);
    for (var field in json) {
      if (field === "captcha") {
        $(".new_ticket").append($("<div>").addClass("se-errors").append($("<p>").addClass("se-error").html("Failed Captcha")));
      } else {
        if (field === "support_type") { field_name = field+"_id"; }
        else { field_name = field; }

        var felem = this.form.find("#ticket_"+field_name);
        var errorsField = felem.parent().find(".se-errors");
        var errors = json[field];

        if (errorsField.length > 0) { errorsField.html(""); }
        else { felem.after($("<div>").addClass("se-errors")); }

        errorsField = felem.parent().find(".se-errors");

        for (var x=0; x < errors.length; x++) {
          var error = errors[x];
          errorsField.append($("<p>").addClass("se-error").html(error));
        }
      }
    }
  }
};

SupportEngine.Toggler = function() {
  this.element = $(".se-widget-toggler");
  this.bind();
};

SupportEngine.Toggler.prototype = {
  bind: function() {
    this.element.on("click", this.toggle.bind());
  },

  toggle: function(event) {
    $(".se-widget").toggleClass("se-widget-open");
    if (!$(".se-widget").hasClass("se-widget-open")) {
      $(".se-widget form").get(0).reset();
    }
  }
};


$(function() {
  if ($('.se-widget').length == 1) {
    new SupportEngine.Widget();
  }
});
