
var arr = [0,1,2,3,4,5,6,7,8,9];
var password="";
var arr2 =["pass4","pass6","pass62"];
var passIndex=0;
var idpass=arr2[passIndex];
var max=4;
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
  
  if(passIndex==0){
    max=4;
  }else if(passIndex==1 || passIndex==2){
    max=6;
  }
  let id=elemento.id;
  if(document.getElementById(idpass).value.length<max){
    password+=document.getElementById(id).value;
    document.getElementById(idpass).value=password;
  }
}

function erase(){
  password="";
  document.getElementById(idpass).value=password;
}

function next(){ 
  password="";
  passIndex++;
  if(passIndex==3){
   passIndex=0;
}	
  idpass=arr2[passIndex];
}
