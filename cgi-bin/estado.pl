#!/usr/bin/perl
use CGI qw(:standard);
use DBI;
use CGI::Session;
my $cgi=new CGI;
$tarjeta=param("tarjeta");

$hostname="localhost";
$username="u20180571";
$password="zgW8kbjv";
$database="u20180571";
$dsn="DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh=DBI->connect($dsn,$username,$password);
$sth1=$dbh->prepare("SELECT ID from cards where Numero like $tarjeta");
$sth1->execute();
@res1=$sth1->fetchrow_array();

$sth2=$dbh->prepare("SELECT Numero from  accounts where Tarjeta_ID like $res1[0]");
$sth2->execute();
@res2=$sth2->fetchrow_array();

$sth3=$dbh->prepare("SELECT Cliente_ID from accounts where Tarjeta_ID like $res1[0]");
$sth3->execute();
@res3=$sth3->fetchrow_array();

$sth4=$dbh->prepare("SELECT Nombres, Paterno , Materno from clients where ID like $res3[0]");
$sth4->execute();
@res4=$sth4->fetchrow_array();

$sth5=$dbh->prepare("SELECT Monto from accounts where Tarjeta_ID like $res1[0]");$sth5->execute();
@res5=$sth5->fetchrow_array();

$sth6=$dbh->prepare("SELECT Monto,Realizado,Tipo,ID from movements where Tarjeta_ID like $res1[0] ORDER BY ID DESC LIMIT 10");
$sth6->execute();

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
print "<link rel=\"stylesheet\" href=\"../css/showStyle.css\">";
print "<title>Estado de cuenta</title></head>\n";
print "<body>\n";
print "<div class=\"cont\">\n";
print "<div id=\"info\">";
print "<fieldset id=\"info2\">";
print "<h1>Numero de tarjeta: <span class=\"n\">$tarjeta</span> </h3>\n";
print "<h2>Numero de cuenta: <span class=\"n\">$res2[0]</span></h2>\n";
print "<h2>Cliente: <span class=\"n\">$res4[0]  $res4[1]  $res4[2]<span></h2>\n";
print "<h2>Monto acumulado en la cuenta: <span class=\"n\">$res5[0]</span></h2>\n";
print "</fieldset>";
print "</div>";
print "<div id=\"tab\">";
print "<table>\n";
print "<th>Monto</th><th>Realizado</th><th>Tipo</th>";
while(@movimientos=$sth6->fetchrow_array()){
        $contador=0;
        print "<tr>";
        while($contador<3){
                if($contador==2){
                        $movimientos[$contador]=~ s/1/Deposito/;
                        $movimientos[$contador]=~ s/2/Retiro/;
                        $movimientos[$contador]=~ s/3/Transferencia (Recibir)/;
                        $movimientos[$contador]=~ s/4/Transferencia (Enviar)/;
                }
                print "<td>$movimientos[$contador]</td>";
                $contador++;
        }
        print "</tr>";
}
print "</table>";
print "</div>";

print "</div>";
print "</body></html>\n";
}
$dbh->disconnect();


