#!/usr/bin/perl
use CGI qw(:standard);

use DBI;
my $usuario=param("usuario");
my $clave=param("clave");
$hostname='localhost';
$port=3306;
$username='u20180571';
$password='zgW8kbjv';
$database='u20180571';
$dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
$dbh = DBI->connect($dsn, $username, $password) or die("No se pudo conectar!");
$sth = $dbh->prepare("select Usuario from users");
$sth->execute();
$sth2 = $dbh->prepare("select Clave from users");
$sth2->execute();
$cosa="xd";
while(@res=$sth->fetchrow_array() and @res2=$sth2->fetchrow_array() ){
  if(($usuario eq "@res") and ($clave eq "@res2")){
	print "Content-type:text/html\n\n";
	print "<!DOCTYPE html>";
	print "<html><head><title>Opciones</title>";
	print "<link rel=\"stylesheet\" href=\"../css/bankStyle.css\"></head>";
	print "<body>";
	print "<h1>Usuario:</h1>";
	print "<p>$usuario</p>";
	print "<form action=\"../cliente.html\">";
	print "<input type=\"hidden\" value=\"$usuario\" name=\"usuario\">";
	print "<input type=\"submit\" value=\"Agregar Cliente\">";
	print "</form>";
	print "<form action=\"../cuenta.html\">";
	print "<input type=\"hidden\" value=\"$usuario\" name=\"usuario\">";
        print "<input type=\"submit\" value=\"Agregar Cuenta\">";
        print "</form>";
	print "<form action=\"../tarjeta.html\">";
	print "<input type=\"hidden\" value=\"$usuario\" name=\"usuario\">";
        print "<input type=\"submit\" value=\"Agregar Tarjeta\">";
        print "</form>";
	print "<form action=\"mostrarClientes.pl\">";
	print "<input type=\"submit\" value=\"Mostar Clientes\">";
	print "</form>";
	print "<form action=\"mostrarCuentas.pl\">";
	print "<input type=\"submit\" value=\"Mostrar Cuentas\">";
	print "</form>";
	print "<form action=\"mostrarTarjetas.pl\">";
	print "<input type=\"submit\" value=\"Mostar Tarjetas\">";
	print "</form>";
	print "</body>";
	print "<script>";
	print "</script>";
	print "</html>";
	$cosa="si";
	last;
  } else{
	$cosa="no";
  }

}
if($cosa eq "no"){
	print "Content-type:text/html\n\n";
        print "<!DOCTYPE html>";
        print "<html><head><title>Opciones</title>";
	print "<meta http-equiv=\"refresh\" content=\"0; url=../usuario.html\">";
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
