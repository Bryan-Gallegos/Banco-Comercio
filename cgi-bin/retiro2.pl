#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
my $cgi=new CGI;
$tarjeta=param("tarjeta");
$monto=param("amount");
$hostname="localhost";
$username="u20180571";
$password="zgW8kbjv";
$database="u20180571";
$dsn="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password);

$sth1=$dbh->prepare("SELECT ID from cards where Numero like $tarjeta");
$sth1->execute();
@res1=$sth1->fetchrow_array();
$sth2=$dbh->prepare("SELECT Monto,Tarjeta_ID,ID FROM accounts where Tarjeta_ID like $res1[0]");
$sth2->execute();
@res2=$sth2->fetchrow_array();
my $session=new CGI::Session;
$session->load();
my @autenticar=$session->param;
if (@autenticar eq 0)
{
	$session->delete();
	$session->flush();
	print $cgi->header("text/html");
	print "<meta http-equiv= 'refresh' content='2; ../index.html'>";
	print "<h3 style='color:red;'>Usted no ha iniciado sesion. Redireccionando...</h3>";
}
elsif ($session->is_expired)
{
	$session->delete();
        $session->flush();
        print $cgi->header("text/html");
        print "<meta http-equiv= 'refresh' content='3; ../index.html'>";
        print "<h3 style='color:red;'>Su sesion ha expirado. Redireccionando...</h3>";

}
else 
{

print "Content-type: text/html\n\n";
print "<!DOCTYPE html>\n";
print "<html><head>\n";
print "<title>Deposito</title></head>\n";
print "<body>";
if ($res2[0]<$monto){
	print "<h1>No hay saldo suficiente para realizar el retiro</h1>";
}
else {
	$newmonto=$res2[0]-$monto;
	$sth3=$dbh->prepare("UPDATE accounts SET Monto=$newmonto WHERE Tarjeta_ID like $res1[0]");
	$sth3->execute();
	print "<h1>Retiro de $monto realizado con exito. Su saldo actual es: $newmonto</h1>";
	$sth3=$dbh->prepare("INSERT INTO movements values(null,$res2[1],$res2[2],$monto,null,2 )");
	$sth3->execute();
}
print "</body></html>\n";
}
$dbh->disconnect();

