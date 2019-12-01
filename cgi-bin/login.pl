#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
my $tipo=param("tipo");
my $tarjeta=param("tarjeta");
my $clave=param("clave");
$hostname='localhost';
$port=3306;
$username='u20180571';
$password='zgW8kbjv';
$database='u20180571';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn, $username, $password) or die("No se pudo conectar!");
$sth = $dbh->prepare("select * from users");
$sth->execute();
print "Content-type: text/html\n\n";
print "<!DOCTYPE html>\n";
print "<head><title>Usuarios</title></head>\n";
print "<body>\n";

while(  @res = $sth->fetchrow_array()){
  printf "<p>@res</p> <BR>\n";
}
print "</body></html>\n";
$dbh->disconnect();
