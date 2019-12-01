
var arr = [0,1,2,3,4,5,6,7,8,9];
var password="";

(function setValue(){
  arr=shuffle(arr);
  var i=0;
  while(i<arr.length){
    let button="button"+i;
    document.getElementById(button).innerHTML=arr[i];
    document.getElementById(button).value=arr[i];
    i++;
  }
})();


function shuffle(arr){
  var index = arr.length, randomIndex, temp;
  while(index>0){
    randomIndex = Math.floor(Math.random()*index);
    index--;
    temp = arr[index];
    arr[index]=arr[randomIndex];
    arr[randomIndex]=temp;
    }
    return arr;
}
console.log(shuffle(arr));

function writes(elemento){
  let id=elemento.id;
  if(document.getElementById("clave").value.length<6){
    password+=document.getElementById(id).value;
    document.getElementById("clave").value=password;
  }
}

function erase(){
  password="";
  document.getElementById("clave").value=password;
}


function getHttpObject(){
  var XMLHttp;
  if(window.XMLHttpRequest){
    XMLHttp = new XMLHttpRequest();
  } else if(window.ActiveXObject){
    XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  return XMLHttp;
}
