#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
my $num=param("numero");
my $div=param("moneda");
my $card=param("tarjeta_id");
my $client=param("cliente_id");
my $usuario=param("usuario");

$username="u20180571";
$database="u20180571";
$port=3306;
$host="localhost";
$password="zgW8kbjv";
$std="DBI:mysql:database=$database;host=$host;port=$port";
$dbh=DBI->connect($std,$username,$password) or die("No se pudo conectar");

$sth=$dbh->prepare("select ID from users where Usuario like '$usuario' limit 1");
$sth->execute();
@row=$sth->fetchrow_array();
$userid=@row[0];


$sth=$dbh->prepare("insert into accounts values (null,'$num',null,1,'$div',$card,$client,$userid,0)");
$sth->execute();
$dbh->disconnect();

print "Content-type:text/html\n\n";
print "<!DOCTYPE html>";
print "<html><head><title>Cliente</title>";
print "<meta http-equiv=\"refresh\" content=\"0; url=mostrarCuentas.pl\">";
print "</head>";
print "<body>";
print "</body></html>";

