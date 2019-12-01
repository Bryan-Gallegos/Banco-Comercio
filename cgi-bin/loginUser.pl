#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
my $cgi= new CGI;
my $usuario=$cgi->param("usuario", $cgi->param("usuario"));
my $clave=$cgi->param("clave",$cgi->param("clave"));
$hostname='localhost';
$port=3306;
$username='u20180571';
$password='zgW8kbjv';
$database='u20180571';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn, $username, $password) or die("No se pudo conectar!");
$sth = $dbh->prepare("select Usuario,Clave from users where Usuario='$usuario' and Clave='$clave'");
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
	print $session->header(-location=> "optionUser.pl");
}
else {
	print "Content-type:text/html\n\n";
        print "<!DOCTYPE html>";
        print "<html><head><title>Opciones</title>";
	print "<meta http-equiv='refresh' content=\"0; url=../usuario.html\">";
        print "<link rel=\"stylesheet\" href=\"../css/bankStyle.css\"></head>";
        print "<body>";
        print "<form action=\"../index.html\">";
        print "</form>";
        print "</body>";
	print "<script>";
	print "alert(\"Usuario y/o clave incorrectos\")";
	print "</script>";
	print "</html>";
}
$dbh->disconnect();

