global.createDocument = function(body) {
  if (!body) {
    body = "<html><body></body></html>";
  }

  global.document = require("jsdom").jsdom(body);
  global.window = global.document.createWindow();
  global.jQuery = require("jquery");
  global.$ = global.jQuery;

  //Test framework
  var jasmine = require('jasmine-node');
  for (var key in jasmine) {
    global[key] = jasmine[key];
  }

  require("./rails.js");
  require("../../../vendor/assets/javascripts/twitter/bootstrap/rails/confirm.coffee");
}