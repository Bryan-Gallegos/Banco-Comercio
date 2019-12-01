#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
$hostname="localhost";
$port=3306;
$username="u20180571";
$password="zgW8kbjv";
$database="u20180571";
$dsn ="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password) or die("No se puede conectar!");
my $cgi =new CGI;
my $session=new CGI::Session;
$session->load();
my @autenticar=$session->param;
if (@autenticar eq 0)
{
	$session->delete();
	$session->flush();
	print $cgi->header("text/html");
	print "<meta http-equiv= 'refresh' content='2; ../usuario.html'>";
	print "<h3 style='color:red;'>Usted no ha iniciado sesion. Redireccionando...</h3>";
}
elsif ($session->is_expired)
{
	$session->delete();
        $session->flush();
        print $cgi->header("text/html");
        print "<meta http-equiv= 'refresh' content='3; ../usuario.html'>";
        print "<h3 style='color:red;'>Su sesion ha expirado. Redireccionando...</h3>";

}
else 
{

$sth1=$dbh->prepare("select ID from accounts");$sth1->execute();
$sth2=$dbh->prepare("select Numero from accounts");$sth2->execute();
$sth3=$dbh->prepare("select Creado from accounts");$sth3->execute();
$sth4=$dbh->prepare("select Estado from accounts");$sth4->execute();
$sth5=$dbh->prepare("select Moneda from accounts");$sth5->execute();
$sth6=$dbh->prepare("select Tarjeta_ID from accounts");$sth6->execute();
$sth7=$dbh->prepare("select Cliente_ID from accounts");$sth7->execute();
$sth8=$dbh->prepare("select Usuario_ID from accounts");$sth8->execute();
$sth9=$dbh->prepare("select Monto from accounts");$sth9->execute();

print "Content-type: text/html\n\n";
print "<!DOCTYPE html>\n";
print "<html><head><title>Cuentas Creadas</title>\n";
print "<link rel=\"stylesheet\" href=\"../css/showStyle.css\">\n";
print "</head>\n";
print "<body>\n";
print "<h1 align=\"center\">Cuentas:</h1>";
print "<div class=\"table\">";
print "<table>";
print "<th>ID</th><th>Numero</th><th>Creado</th><th>Estado</th><th>Moneda</th><th>Tarjeta_ID</th><th>Cliente_ID</th><th>Usuario_ID</th><th>Monto</th>";
while( @res1=$sth1->fetchrow_array()){
	@res2=$sth2->fetchrow_array();
	@res3=$sth3->fetchrow_array();
	@res4=$sth4->fetchrow_array();
        @res5=$sth5->fetchrow_array();
	@res6=$sth6->fetchrow_array();
        @res7=$sth7->fetchrow_array();
	@res8=$sth8->fetchrow_array();
	@res9=$sth9->fetchrow_array();
	print "<tr><td>@res1</td><td>@res2</td><td>@res3</td><td>@res4</td><td>@res5</td><td>@res6</td><td>@res7</td><td>@res8</td><td>@res9</td></tr>";

}
print "</table>";
print "</div>";
print "</body></html>\n";
}
$dbh->disconnect();
