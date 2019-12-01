#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
$tarjeta=param("tarjeta");
$monto=param("amount");
$hostname="localhost";
$username="u20180571";
$password="zgW8kbjv";
$database="u20180571";
$dsn="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password);
$sth=$dbh->prepare("SELECT Numero FROM cards");
$sth->execute();
$sth3=$dbh->prepare("SELECT Monto FROM cards");
$sth3->execute();
print "Content-type: text/html\n\n";
print "<!DOCTYPE html>\n";
print "<html><head>\n";
print "<title>Deposito</title></head>\n";
print "<body>";
$message="";
while(@res=$sth->fetchrow_array() and @res2=$sth3->fetchrow_array()){
	if($tarjeta eq "@res"){
		
		$newmonto=@res2+$monto;
		$sth2=$dbh->prepare("UPDATE cards SET Monto=$newmonto WHERE Numero like $tarjeta");
		$sth2->execute();
		$message=":) Deposito Realizado";
		last;
	}	
	else{
		$message=":( Deposito no Realizado";
	}
}
print "<h1>$message</h1>\n";
print "</body></html>\n";
$dbh->disconnect();

