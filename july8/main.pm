package main;
#!/usr/bin/perl
use DBI;
use strict;
use warnings;
use registerinput;
use Email::Valid;
my $sth;
my $driver = "mysql"; 
my $database = "PhoneBook";
my $hostname="localhost";
my $dsn = "DBI:$driver:database=$database:host=$hostname";
my $userid = "root";
my $password = "mysql";
my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;
my ($father_name,$address,$mother_name,$mobile,$sex,$email,$citizen_no,$input);
print "\t\t\t\t\t\t\t************WELCOME TO PHONE BOOK************\t\t\n";
print "\n\t\t\t\t\t\t\t\t\t\tMenu\t\t\t\n\n";
print "\t\t\t\t\t\t\t\t1.Add New            2.List           3.Exit      \n";
print "\t\t\t\t\t\t\t\t4.Modify             5.Search         6.Delete     \n"; 
# choose the operation to be performed
print "\t\t\t\t\t\tEnter any key\n";
$input=<STDIN>;
chomp($input);
if($input==1)
{
$my Object = Registerinput->input();
}

1;
