package Validation;
use PhoneBook;
use strict;
use warnings;
use DBI;
use Email::Valid;
my ($dbh1,$sth, $driver,$database,$hostname,$dsn,$userid,$password);
my ($name,$address,$father_Name,$mother_Name,$mobile_Number,$gender,$email,$citizen_Number);
my($class,$count);
sub Connection
{
     $driver = "mysql"; 
     $database = "PhoneBook";
     $hostname="localhost";
     $dsn = "DBI:$driver:database=$database:host=$hostname";
     $userid = "root";
     $password = "mysql";
    eval
    {
        $dbh1 = DBI->connect($dsn, $userid, $password );
    };
    if($@)
    {
        return "false";
    }
    return $dbh1;
}

my $object1=new PhoneBook();
my $dbh=$PhoneBook::self->{dbh};

sub NameValidation
{
 $class=shift;
 $name=shift;
if($name =~ /^[A-Z a-z,]*$/)
{
return "true";
}
else
{
return "false";
}

}

sub MobileValidation
{
$class=shift;
my $mobile_Number=shift;
if (length($mobile_Number)==10 &&  $mobile_Number=~m{^[6-9]})
{
return "true";
}
else
{
return "false";
}
}


sub EmailValidation
{
$class=shift;
my $email=shift;
unless( Email::Valid->address($email) ) 
{
    print "Sorry, from email address is not valid!";
return "false";
}
else
{
return "true";
}
}


sub CitizenNumberValidation
{
$class=shift;
my $citizen_Number=shift;
if($citizen_Number =~ /^[0-9,]*$/)
{
return "true";
}
else
{
return "false";
}
}

sub RegisterData
{
my $class=shift;
my $name=shift;
my $address=shift;
my $father_Name=shift;
my $mother_Name=shift;
my $mobile_Number=shift;
my $gender=shift;
my $email=shift;
my $citizen_Number=shift;

eval
{
my $sth =$PhoneBook::self->{insert};
$sth->execute($name,$address,$father_Name,$mother_Name,$mobile_Number,$gender,$email,$citizen_Number);
};
if($@)
{
print "duplicate Entry of data\n";
return "false";
}
else
{
return "true";
}
}

sub ViewList
      { 
      eval
         {
          $sth =$PhoneBook::self->{viewall};
          $sth->execute();
         };
       if($@)
         {
         return "Error";
         }
# Bind Perl variables to columns:
$sth->bind_col( 1, \$name);
$sth->bind_col( 2, \$address);
$sth->bind_col( 3, \$father_Name);
$sth->bind_col( 4, \$mother_Name);
$sth->bind_col( 5, \$mobile_Number);
$sth->bind_col( 6, \$gender);
$sth->bind_col( 7, \$email);
$sth->bind_col( 8, \$citizen_Number);
#printing the binded column using fetch function 
print"===========================================================================================================================\n";
print"Name      Address      Father_Name     Mother_Name    Mobile_Number   Gender          Email                    Citizen_NO\n";
print"===========================================================================================================================\n";
while ($sth->fetch)
   {
    print "$name     $address     $father_Name     $mother_Name     $mobile_Number     $gender     $email     $citizen_Number\n";
    }
print"============================================================================================================================\n";
return "true";
}

sub ViewParticularDataList
   {
    $class=shift;
    $mobile_Number=shift;
    $count=0;
    eval
       {
        $sth =$PhoneBook::self->{mobilenum};
        $sth->execute($mobile_Number);
       };
     if($@)
       {
        return "Error";
       }
# Bind Perl variables to columns:
$sth->bind_col( 1, \$name);
$sth->bind_col( 2, \$address);
$sth->bind_col( 3, \$father_Name);
$sth->bind_col( 4, \$mother_Name);
$sth->bind_col( 5, \$mobile_Number);
$sth->bind_col( 6, \$gender);
$sth->bind_col( 7, \$email);
$sth->bind_col( 8, \$citizen_Number);
$count=0;
#printing the binded column using fetch function 
print"===========================================================================================================================\n";
print"Name      Address      Father_Name     Mother_Name    Mobile_Number   Gender          Email                    Citizen_NO\n";
print"===========================================================================================================================\n";
while ($sth->fetch)
      {
       print "$name     $address     $father_Name     $mother_Name     $mobile_Number     $gender     $email     $citizen_Number\n";
       $count++;
      }

print"============================================================================================================================\n";
if($count==0)
  {
   return "false";
  }
if($count>=1)
  {
return "true";
}
}

sub UpdateName
{
    $class=shift;
    $name=shift;
    $mobile_Number=shift;
    $count=0;
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updname};
   $sth->execute($name,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}



sub UpdateAddress
{
    $class=shift;
    $address=shift;
    $mobile_Number=shift;
    $count=0;
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updaddress};
   $sth->execute($address,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}



sub UpdateFatherName
{
    $class=shift;
    $father_Name=shift;
    $mobile_Number=shift;
    $count=0;
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updfathername};
   $sth->execute($father_Name,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}



sub UpdateMotherName
{

    $class=shift;
    $mother_Name=shift;
    $mobile_Number=shift;
   
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updmothername};
   $sth->execute($mother_Name,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}



sub UpdateMobileNumber
{
    $class=shift;
    $name=shift;
    $mobile_Number=shift;
eval
{
$sth = $dbh->prepare(q{ SELECT * FROM Register where name_=? });
$sth->execute($name);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth = $dbh->prepare(q{ update Register set mobile_number=? where name_=?});
   $sth->execute($mobile_Number,$name);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}



sub UpdateGender
{
    $class=shift;
    $gender=shift;
    $mobile_Number=shift;
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updgender};
   $sth->execute($gender,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}



sub UpdateEmail
{
    $class=shift;
    $email=shift;
    $mobile_Number=shift;
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updemail};
   $sth->execute($email,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}


sub UpdateCitizenNumber
{
    $class=shift;
    $citizen_Number=shift;
    $mobile_Number=shift;
eval
{
$sth =$PhoneBook::self->{mobilenum};
$sth->execute($mobile_Number);
};
if($@)
{
return "Error";
}
while ($sth->fetch)
 {
$count++;
}
if($count>=1)
{
 eval
  {
   $sth =$PhoneBook::self->{updcitizennumber};
   $sth->execute($citizen_Number,$mobile_Number);
   return "true";
  };
 if($@)
 {
 return "Error";
 }
}
else
{
return "false";
} 
}

sub RemoveData
      {
       $class=shift;
       $mobile_Number=shift;
       $count=0;
       eval
          {
           $sth =$PhoneBook::self->{mobilenum};
           $sth->execute($mobile_Number);
          };
        if($@)
          {
           return "Error";
          }
        while ($sth->fetch)
             {
              $count++;
             }
        if($count>=1)
          {
           eval
              {
               $sth = $PhoneBook::self->{remove};
               $sth->execute($mobile_Number);
               return "true";
              };
            if($@)
              {
               return "Error";
              }
          }
         else
             {
              return "false";
             }
     }
sub DataValidation
 {
    $class=shift;
    $name=shift;
    $mobile_Number=shift;
    $count=0;
   eval
      {
       $sth = $PhoneBook::self->{search};
       $sth->execute($name,$mobile_Number);
      };
    if($@)
      {
       return "Error";
      }
# Bind Perl variables to columns:
$sth->bind_col( 1, \$name);
$sth->bind_col( 2, \$address);
$sth->bind_col( 3, \$father_Name);
$sth->bind_col( 4, \$mother_Name);
$sth->bind_col( 5, \$mobile_Number);
$sth->bind_col( 6, \$gender);
$sth->bind_col( 7, \$email);
$sth->bind_col( 8, \$citizen_Number);
#printing the binded column using fetch function 
print"===========================================================================================================================\n";
print"Name      Address      Father_Name     Mother_Name    Mobile_Number   Gender          Email                    Citizen_NO\n";
print"===========================================================================================================================\n";
while ($sth->fetch)
      {
    print "$name     $address     $father_Name     $mother_Name     $mobile_Number     $gender     $email     $citizen_Number\n";
    $count++;
}
print"============================================================================================================================\n";



if($count==0)
  { 
   return "false";
  }
else
   {
    return "true";
   }
}
1;
