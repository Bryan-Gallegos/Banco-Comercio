function getHttpObject(){
  var XMLHttp;
  if (window.XMLHttpRequest) {
    XMLHttp = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  return XMLHttp;
}

var http = getHttpObject();

function redirect(){
	document.getElementById("f").action="cgi-bin/login.pl";
}

