var card=window.location.search;
var dflt="?tarjeta=";
card=card.substring(dflt.length,card.length);
document.getElementById("cardNum").innerHTML=card;
document.getElementById("cardInput").value=card;
