#!/usr/bin/perl
use MIME::Lite;
use DBI;
use strict;
use warnings;
use Email::Valid;
require login;
require register;
my $sth;
my $driver = "mysql"; 
my $database = "messageApp";
my $hostname="localhost";
my $dsn = "DBI:$driver:database=$database:host=$hostname";
my $userid = "root";
my $password = "mysql";
my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;
my ($father_name,$address,$mother_name,$mobile,$sex,$email,$citizen_no,$input);
print "           **********Welcome to phone Book**********       ";
print "                            Menu\n";
print "       1.Add New            2.List           3.Exit      \n";
print "       4.Modify             5.Search         6.Delete     \n"; 

$input=<STDIN>;
chomp($input);

#Login
  if($input==1)
   {
     print "login your account\n";
     print "Enter the emailId\n";
     $email=<STDIN>;
     chomp($email);
     print "Enter the Mobile Number\n";
     $mobile=<STDIN>;
     chomp($mobile);
 $object=new login($email,$mobile);
  }
   
#Register
else
{
      label:
       print "Register the account\n";
#email 
       print "Enter the email id\n";
       $email=<STDIN>;
        chomp($email);
#mobile Number
        print "Enter the mobile number\n";
        $mobile=<STDIN>;
        chomp($mobile);
        $subject = 'Test Email';
        $message = '<p>Hi all, <\br> Greetings. <\br> welcome to aspire systems<p> ';

#validating the email address

        unless( Email::Valid->address($email) )
         {
         print "Sorry, from email address is not valid!";
         goto label;
         }
 $object=new register($email,$mobile);
        $sth=$dbh->prepare("insert into register(mobile,email) values(?,?)");
        $sth->execute($mobile,$email);
}

#for sending email

        $sth=$dbh->prepare("SELECT email,mobile  FROM register where email=? ");
        $sth->execute($email);
        if ($dbh->selectrow_array($sth, undef, $email))
{
          print "this mail is exist in database";
          $msg = MIME::Lite->new(
                 to       => $email,
                 Subject  => $subject,
                 Type     => 'multipart/mixed'
                 );
# Add your text message.
          $msg->attr(Type         => 'text/html',
             Data         => $message
             );
        print "Enter if you want to attach the image\n";
        $choice=<STDIN>;
        chomp($choice);

# Specify your file as attachement.
       if($choice eq "yes"||"YES")
      {
            $msg->attach(Type         => 'image/gif',
                 Path         => '/home/adpc-56/PerlRepository/Natural.jpg',
                   Filename     => 'Natural.jpg',
                Disposition  => 'attachment'
                ); 
       }    
      $msg->send;
      print "Email Sent Successfully\n";

}
else
{
print "You need to register";
goto label;
}

