function getHttpObject(){
	var XMLHttp;
	if(window.XMLHttpRequest){
		XMLHttp=new XMLHttpRequest();
	}else{
		XMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	return XMLHttp;
}

var http=getHttpObject();

function getData(var num){
if(http){
	var url="../cgi-bin/select.pl?select="+num;
	http.onreadystatechange=function(){
		//var selectId="select"+num;
		var divId="div"+num;
		//var select_element=document.getElementById(selectId);
		var div_element=document.getElementById(divId);
		if(http.readyState==4 && http.status==200){
			div_element.innerHTML=http.responseText;
		}
	}
	http.open("GET",url);
	http.send();
}
}
getData("1");
getData("2");

