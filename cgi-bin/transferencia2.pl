#!/usr/bin/perl -wT
use CGI qw(:standard);
use DBI;
use CGI::Session;
my $monto=param("amount");
my $destino=param("destino");
my $tarjeta=param("tarjeta");
$hostname='localhost';
$username='u20180571';
$password='zgW8kbjv';
$database='u20180571';
$port=3306;
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn,$username,$password) or die ("No se pudo conectar!");
$sth=$dbh->prepare("SELECT ID FROM cards WHERE Numero like $tarjeta");
$sth->execute();

my $session=new CGI::Session;
$session->load();
my $cgi=new CGI;
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

while(@res=$sth->fetchrow_array()){
	$sth2=$dbh->prepare("SELECT Monto FROM accounts WHERE Tarjeta_ID like @res and Monto>$monto");
	$owner_id=$res[0];
}
$sth2->execute();
while(@owner_amount=$sth2->fetchrow_array()){
if(@owner_amount==0){
	$message="Monto insuficiente para realizar transferencia";
}else{
	$sth=$dbh->prepare("SELECT ID FROM cards WHERE Numero like $destino");
	$sth->execute();
	@account_id=$sth->fetchrow_array();
	$id=$account_id[0];
	if(@account_id==0){
		$message="Numero de tarjeta inexistente";
	}else{
		$sth2=$dbh->prepare("SELECT Monto FROM accounts WHERE Tarjeta_ID like $id");
		$sth2->execute();
		@account_amount=$sth2->fetchrow_array();
		$account_amount[0]+=$monto;
		$sth=$dbh->prepare("UPDATE accounts SET Monto=$account_amount[0] where Tarjeta_ID like $id");
		$sth->execute();
		$sth=$dbh->prepare("SELECT Tarjeta_ID,ID FROM movements where Tarjeta_ID like $id");
		$sth->execute();
		while(@row=$sth->fetchrow_array()){
			$sth2=$dbh->prepare("INSERT INTO movements values(null,$row[0],$row[1],$monto,null,3)");
			$sth2->execute();
		}
		$newmonto=$owner_amount[0]-$monto;
		$sth=$dbh->prepare("UPDATE accounts SET Monto=$newmonto where Tarjeta_ID like $owner_id");
		$sth->execute();
		$sth=$dbh->prepare("SELECT Tarjeta_ID,ID FROM accounts where Tarjeta_ID like $owner_id");
                $sth->execute();
                while(@row=$sth->fetchrow_array()){
                        $sth2=$dbh->prepare("INSERT INTO movements values(null,$row[0],$row[1],$monto,null,4)");
                        $sth2->execute();
                }

		$message=":) Transferencia Realizada";
}
}
}
print "Content-type: text/html \n\n";
print "<!DOCTYPE html>\n";
print "<html><head>\n";
print "<title>Transferencias</title></head>\n";
print "<body>\n";
print "<h1>$message</h1>\n";
print "</body>\n</html>";
$sth2->finish();
$sth->finish();
}
$dbh->disconnect();
