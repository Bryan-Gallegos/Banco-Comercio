#!/usr/bin/perl -wT
use CGI qw(:standard);
use DBI;
use Time::Piece;
my $num=param("numero");
my $clave=param("clave");
#$num="123123";
#$clave=123456;
$username="u20180571";
$database="u20180571";
$port=3306;
$host="localhost";
$password="zgW8kbjv";
$std="DBI:mysql:database=$database;host=$host;port=$port";
$dbh=DBI->connect($std,$username,$password) or die("No se pudo conectar");


my $date=localtime;
$d1=$date->datetime;
$d1=~s/T/ /s;
$date=$date->add_years(2);
$d=$date->datetime;
$d=~s/T/ /s;

$sth=$dbh->prepare("insert into cards values(NULL,$num,$clave, '$d1' , '$d' , '1', '1')");

$sth->execute();
print "Content-type:text/html\n\n";
print "<!DOCTYPE html>";
print "<html><head><title>Cliente</title><meta http-equiv=\"refresh\" content=\"0; url=mostrarTarjetas.pl\"></head>";
print "<body>";
print "</body></html>";
$dbh->disconnect();
