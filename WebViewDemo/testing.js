function testingFunction() {
  var value = "SSSSSSSTOKEN";
  var action = "login"
  document.getElementById("demo").innerHTML = "Paragraph changed in "+ value;
  window.webkit.messageHandlers.jsToOc.postMessage(action, value);

}

function testingFunction_FromXcode(){
    var value = "testingFunction_FromXcode";
    var action = "login"
    document.getElementById("demo").innerHTML = "Paragraph changed in "+ value;
    window.webkit.messageHandlers.jsToOc.postMessage(action, value);

}
