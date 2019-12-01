#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
my $dni=param("dni");
my $name=param("nombres");
my $paterno=param("paterno");
my $materno=param("materno");
my $date=param("nacim");
my $usuario=param("usuario");
$username="u20180571";
$database="u20180571";
$port=3306;
$host="localhost";
$password="zgW8kbjv";
$std="DBI:mysql:database=$database;host=$host;port=$port";
$dbh=DBI->connect($std,$username,$password) or die("No se pudo conectar");

$sth=$dbh->prepare("select ID from clients order by ID DESC limit 1");
$sth->execute();
@row=$sth->fetchrow_array();
$id=@row[0];
$id++;

$sth=$dbh->prepare("select ID from users where Usuario like '$usuario' limit 1");
$sth->execute();
@row=$sth->fetchrow_array();
$userid=@row[0];

$sth=$dbh->prepare("insert into clients values ($id,'$dni','$name','$paterno','$materno','$date',null,1,$userid)");
$sth->execute();
$dbh->disconnect();
print "Content-type:text/html\n\n";
print "<!DOCTYPE html>";
print "<html><head><title>Cliente</title>";
print "<meta http-equiv=\"refresh\" content=\"0; url=mostrarClientes.pl\">";
print "</head>";
print "<body>";
print "</body></html>";

