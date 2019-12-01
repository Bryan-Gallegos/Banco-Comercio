#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
$hostname="localhost";
$username="u20180571";
$port=3306;
$password="zgW8kbjv";
$database="u20180571";
$dsn="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password) or die("No se pudo Conectar!");
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

$sth1=$dbh->prepare("select ID from cards");$sth1->execute();
$sth2=$dbh->prepare("select Numero from cards");$sth2->execute();
$sth3=$dbh->prepare("select Clave from cards");$sth3->execute();
$sth4=$dbh->prepare("select Creado from cards");$sth4->execute();
$sth5=$dbh->prepare("select Estado from cards");$sth5->execute();
$sth6=$dbh->prepare("select Sellado from cards");$sth6->execute();
$sth7=$dbh->prepare("select Vencimiento from cards");$sth7->execute();
print "Content-type: text/html\n\n";
print "<!DOCTYPE html>\n";
print "<html><head>\n";
print "<title>Tarjetas Creadas</title>\n";
print "<link rel=\"stylesheet\" href=\"../css/showStyle.css\">\n";
print "</head>\n";
print "<body>\n";
print "<h1 align=\"center\">Tarjetas:</h1>";
print "<div class=\"table\">";
print "<table>";
print "<th>ID</th><th>Numero</th><th>Clave</th><th>Creado</th><th>Estado</th><th>Sellado</th><th>Vencimiento</th>";
while( @res1=$sth1->fetchrow_array()){
	@res2=$sth2->fetchrow_array();
        @res3=$sth3->fetchrow_array();
        @res4=$sth4->fetchrow_array();
        @res5=$sth5->fetchrow_array();
        @res6=$sth6->fetchrow_array();
        @res7=$sth7->fetchrow_array();
        print "<tr><td>@res1</td><td>@res2</td><td>@res3</td><td>@res4</td><td>@res5</td><td>@res6</td><td>@res7</td></tr>";
}
print "</table>";
print "</div>";
print "</body></html>";
}
$dbh->disconnect();
