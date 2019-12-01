#!/usr/bin/perl
use CGI;
use CGI::Session;
use DBI;
my $session = new CGI::Session;
my $cgi =new CGI;
$session->load();
$session->delete();
$session->flush();
print $session->header(-location => "../index.html");
