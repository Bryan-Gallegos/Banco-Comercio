var user=window.location.search;
var deflt="?usuario="; 
user=user.substring(deflt.length,user.length);
var ind=user.indexOf("+");
if(ind!=-1){
	var part1=user.substring(0,ind);
	var part2=user.substring(ind+1,user.length);
	user=part1+" "+part2;
}
document.getElementById("user").innerHTML=user;
document.getElementById("userinput").value=user;
