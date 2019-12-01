#!/usr/bin/perl -wT
use CGI qw(:standard);
use DBI;
use CGI::Session;
my $cgi=new CGI;
my $tarjeta=$cgi->param("tarjeta", $cgi->param("tarjeta"));
my $clave=$cgi->param("clave", $cgi->param("clave"));
$hostname='localhost';
$port=3306;
$username='u20180571';
$password='zgW8kbjv';
$database='u20180571';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn, $username, $password) or die("No se pudo conectar!");
$sth = $dbh->prepare("select Numero,Clave from cards where Numero='$tarjeta' and Clave='$clave'");
$sth->execute();
my $encontrar=0;
while($sth->fetchrow_array() ){
  $encontrar=1;
}
if ($encontrar eq 1){
	my $session = new CGI::Session;
	$session->save_param($cgi);
	$session->expires("+30m");
	$session->flush();
	print $session->header(-location=> "privClient.pl");
}
elsif($encontrar eq 0){
	$html= qq{Content-type: text/html

	<!DOCTYPE html>
        <html>
        <head>
        <title>Titulo</title>
	<meta http-equiv="refresh" content="0; url=../index.html">
        </head>
        <body>
        </body>
        <script>
        alert("Numero de Tarjeta y/o Clave Incorrectos");
        </script>
        </html>
        }
}
print $html;
