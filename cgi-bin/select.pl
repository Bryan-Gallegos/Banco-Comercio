#!/usr/bin/perl
use CGI;
use DBI;
$hostname="localhost";
$port=3306;
$username="u20180571";
$password="zgW8kbjv";
$database="u20180571";
$dsn="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password) or die("NO se puede conectar!");
$sth=$dbh->prepare("SELECT ID,Nombres, Paterno, Materno FROM clients");
$sth->execute();
$sth2=$dbh->prepare("SELECT cards.ID, cards.Numero FROM cards where cards.ID not in (select distinct(Tarjeta_ID) from accounts)");
$sth2->execute();
print "Content-type: text/html\n\n";
#print "<!DOCTYPE html>\n";
#print "<html>\n<head>\n<title>Select</title>\n</head>\n<body>\n";
print "<select name=\"cliente_id\">\n";
while(@clients=$sth->fetchrow_array()){
printf "<option value=\"$clients[0]\">$clients[1] $clients[2] $clients[3]</option>\n";
}
print "</select><br>\n";
print "<select name=\"tarjeta_id\">\n";
while(@cards=$sth2->fetchrow_array()){
printf "<option value=\"$cards[0]\">$cards[1]</option>\n";
}
print "</select><br>\n";

#print "</body>\n</html>";
