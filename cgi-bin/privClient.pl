#!/usr/bin/perl -wT
use CGI qw(:standard);
use CGI;
use CGI::Session;
use DBI;
my $cgi =new CGI;
my $session=new CGI::Session;
$session->load();
my @autenticar=$session->param;
$tarjeta=$session->param("tarjeta");
$clave=$session->param("clave");

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
        print "<meta http-equiv= 'refresh' content='3; ../usuario.html'>";
        print "<h3 style='color:red;'>Su sesion ha expirado. Redireccionando...</h3>";

}
else {
	print "Content-type:text/html\n\n";
	print "<!DOCTYPE html>";
	print "<html><head><title>Titulo</title></head><body>";
	print "<form action=\"../clientOptions.html\" id=\"f\">";
	print "<input type=\"hidden\" value=\"$tarjeta\" name=\"tarjeta\">";
	print "</form>";
	print "<h1 style='color:red;'>Bienvenido</h1>";
	print "</body>";
	print "<script>";
	print "document.getElementById(\"f\").submit();";
	print "</script></html>";
}
