#!/usr/bin/perl 
use DBI;
use CGI qw(:standard);
$database='u20180571';
$host='localhost';
$port='3306';
$password='zgW8kbjv';
$username='u20180571';
my $id=param('id');
my $dni=param('dni');
my $nombre=param('name');
my $paterno=param('paterno');
my $materno=param('materno');
my $nacimiento=param('nacimiento');
my $estado=param('estado');
$dsn="DBI:mysql:database=$database;host=$host;port=$port";
$dbh=DBI->connect($dsn,$username,$password);
$sth=$dbh->prepare("UPDATE clients set DNI=\"$dni\", Nombres=$nombre, Paterno=$paterno, Materno=$materno, Nacimiento=\"$nacimiento\", Estado=$estado where ID=$id");
$sth->execute();
$dbh->disconnect();
print "Content-type:text/html\n\n";
print "<!DOCTYPE html>\n";
print "<html><head><meta http-equiv=\"refresh\" content=\"0; url=mostrarClientes.pl\"></head>\n";
print "<body></body></html>";
