#!/usr/bin/perl
use CGI;
use CGI::Session;
use DBI;
my $cgi =new CGI;
my $session=new CGI::Session;
$session->load();
my @autenticar=$session->param;
$usuario=$session->param("usuario");
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
print "<form action=\"editClients.pl\">";
print "<input type=\"submit\" value=\"Editar Clientes\">";
print "</form>";
print "<form action=\"editAccounts.pl\">";
print "<input type=\"submit\" value=\"Editar Cuentas\">";
print "</form>";
print "<form action=\"editCards.pl\">";
print "<input type=\"submit\" value=\"Editar Tarjetas\">";
print "</form>";
print "<a href=\"exit2.pl\">Cerrar Sesion</a>";
print "</body>";
print "<script>";
print "</script>";
print "</html>";
}
