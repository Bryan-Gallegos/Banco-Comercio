#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
$tarjeta=param("tarjeta");
$monto=param("amount");

$hostname="localhost";
$username="u20180571";
$password="zgW8kbjv";
$database="u20180571";
$dsn="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password);
$sth=$dbh->prepare("SELECT cards.ID, accounts.ID from cards, accounts where cards.Numero like $tarjeta");
$sth->execute();
@card_id=$sth->fetchrow_array();
$sth=$dbh->prepare("SELECT Monto FROM accounts WHERE Tarjeta_ID like $card_id[0]");
$sth->execute();

print "Content-type: text/html\n\n";
@res=$sth->fetchrow_array();		
$newmonto=$res[0]+$monto;
$sth=$dbh->prepare("UPDATE accounts SET Monto=$newmonto WHERE TARJETA_ID like $card_id[0]");
$sth->execute();
$sth=$dbh->prepare("INSERT INTO movements values(null, $card_id[0],$card_id[1],$monto,null,1)");
$sth->execute();
$message="Deposito de $monto realizado. Su saldo actual es: $newmonto";
print "<h1 style=\"text-align:center\">$message</h1>\n";
$dbh->disconnect();

