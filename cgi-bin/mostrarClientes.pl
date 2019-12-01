#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
$hostname='localhost';
$port=3306;
$username='u20180571';
$password='zgW8kbjv';
$database='u20180571';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn, $username, $password) or die("No se pudo conectar!");
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

$sth = $dbh->prepare("select * from clients");
$sth1 = $dbh->prepare("select ID from clients");
$sth2 = $dbh->prepare("select DNI from clients");
$sth3 = $dbh->prepare("select Nombres from clients");
$sth4 = $dbh->prepare("select Paterno from clients");
$sth5 = $dbh->prepare("select Materno from clients");
$sth6 = $dbh->prepare("select Nacimiento from clients");
$sth7 = $dbh->prepare("select Creado from clients");
$sth8 = $dbh->prepare("select Estado from clients");
$sth9 = $dbh->prepare("select Usuarios_Id from clients");
$sth1->execute();
$sth2->execute();
$sth3->execute();
$sth4->execute();
$sth5->execute();
$sth6->execute();
$sth7->execute();
$sth8->execute();
$sth9->execute();


print "Content-type: text/html\n\n";
print "<!DOCTYPE html>";
print "<html><head><title>Clientes Creados</title>";   
print "<link rel=\"stylesheet\" href=\"../css/showStyle.css\">";
print "</head>";
print "<body>";
print "<h1 align=\"center\">Clientes:</h1>";
print "<div class=\"table\">";
print "<table>";
print "<th>ID</th><th>DNI</th><th>Nombres</th><th>Paterno</th><th>Materno</th><th>Nacimiento</th><th>Creado</th><th>Estado</th><th>Usuario_ID</th>";
while( @res1 = $sth1->fetchrow_array()){
        @res2 = $sth2->fetchrow_array();
	@res3 = $sth3->fetchrow_array();
        @res4 = $sth4->fetchrow_array();
        @res5 = $sth5->fetchrow_array();
	@res6 = $sth6->fetchrow_array();
        @res7 = $sth7->fetchrow_array();
	@res8 = $sth8->fetchrow_array();
        @res9 = $sth9->fetchrow_array();
	print "<tr><td>@res1</td><td>@res2</td><td>@res3</td><td>@res4</td><td>@res5</td><td>@res6</td><td>@res7</td><td>@res8</td><td>@res9</td></tr>";
}
print "</table>";
print "</div>";
print "</body></html>";
}$dbh->disconnect();

