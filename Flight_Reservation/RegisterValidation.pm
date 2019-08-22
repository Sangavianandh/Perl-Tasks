package RegisterValidation;
use FlightBook;
use strict;
use warnings;
use Email::Valid;
use DBI;
my ($name,$class,$age);
my ($dbh,$sth, $driver,$database,$hostname,$dsn,$userid,$password,$sth1,$sth2,$sth3);
my ($ID,$Flight_ID,$Flight_Name,$Travel_Place_ID,$Seat_Availability,$Starting_Time,$Destination_Time);
my ($passenger_name,$passenger_email,$passenger_mobile_Number);
my($email,$mobile_Number,$Id);
my($from,$to,$date,$id);
sub Connection
{
     $driver = "mysql"; 
     $database = "FlightReservation";
     $hostname ="localhost";
     $dsn = "DBI:$driver:database=$database:host=$hostname";
     $userid = "root";
     $password = "mysql";
    eval
    {
      $dbh = DBI->connect($dsn, $userid, $password );
    };
    if($@)
    {
        return "false";
    }
    return $dbh;
}

sub NameValidation
{
  $class=shift;
  $name=shift;
  if($name =~ /^[A-Za-z]*/ && $name =~/[^\s]/)
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
  $mobile_Number=shift;
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
  $email=shift;
  unless( Email::Valid->address($email) ) 
    {
      print "Sorry, Entered email address is not valid!";
      return "false";
    }
  else
   {
    return "true";
   }
}

sub GenderValidation
{
  $class=shift;
  $name=shift;
  if($name eq "female" or $name eq "male" or $name eq "others" )
    {
     return "true";
    }
  else
    {
     return "false";
    }
}

sub LoginData
{
   
    $class=shift;
    $id=shift;
    $name=shift;
    $mobile_Number=shift;
    my $count=0;
    eval
       {
        $sth =$FlightBook::self->{register};
        $sth->execute($mobile_Number,$name);
       };
     if($@)
       {
        return "Error";
       }
   while($sth->fetch)
       {
        $count++;
       }

   if($count==0)
     {
      return "register";
     }
   my $count1=0;
   eval
       {
        $sth =$FlightBook::self->{register1};
        $sth->execute($id,$mobile_Number,$name);
       };
     if($@)
       {
        return "Error";
       }
     while ($sth->fetch)
       {
        $count1++;
       }

   if($count1==0)
     {
      return "false";
     }
      else
       {
        return "true";
       }
 
}

sub RegisterData
{
   $class=shift;
   $name=shift;
   $email=shift;
   $mobile_Number=shift;
   my $count3=0;
      $sth = $FlightBook::self->{login};
      $sth->execute($mobile_Number);
   while ( my ($field1) = $sth->fetchrow_array() ) 
         {
          $ID=$field1;
          $count3++;
         }
    if($count3>=1)
      {
       return "duplicate";
      }
   eval
    {
     $sth =$FlightBook::self->{insert};
     $sth->execute($name,$email,$mobile_Number);
   };
  if($@)
    {
     return "Error";
    }
    $sth = $FlightBook::self->{Display_id};
    $sth->execute($mobile_Number);
  while(my($field1) = $sth->fetchrow_array() )
       {
        $ID=$field1;
        print "your id is $ID\n";
       }
    if($@)
      {
       return "Error";
      }
   else
      {
       return $ID;
      }
}

sub DOJ
{
$class=shift;
my $dob=shift;
my ($month,$year);
$year=2019;
$month=07;
 
if($dob=~  m/((19|20)\d\d)[- \/](0[1-9]|1[012])[- \/](0[1-9]|[12][0-9]|3[01])/)
     {
     if($3==02 && $4>29) 
       {

        return 1;
       }
     if(!($1 % 4==0 && ($1 % 100!=0 || $1 % 400== 0)) && $3==2 && $4==29)
       {
        return 2;
       }
     if($4==31 and ($3==4 or $3==6 or $3==9 or $3==11))
       {
        return 3;
       } 
     if($1>$year){
     return 4;            
     }
if($3 > $month)
{
return 5;
}
return "true";
}
else
{
return "false";
}
}

sub DOB
{
$class=shift;
my $dob=shift;
my @today = localtime();  
my $year = $today[5]+1900;
my $month = $today[4];
my $date = $today[3];
if($dob=~ m/((19|20)\d\d)[- \/](0[1-9]|1[012])[- \/](0[1-9]|[12][0-9]|3[01])/)
     {
     if($3==02 && $4>29) 
       {
        return 1;
       }
     if(!($1 % 4==0 && ($1 % 100!=0 || $1 % 400==0)) && $3==2 && $3==29)
       {
        return 2;
       }
     if($4==31 and ($3==4 or $3==6 or $3==9 or $3==11))
       {
        return 3;
       } 
     if($1<=$year )
       {
        if($3<=$month)
           {
          if($4<=$date)
           {
            
           }
          }
        }
     else
       {
        return 5;
       }
if($year>=2000)
{
$age=$year-$1;
}
else
{
my $data1=2000-$1;
my $data2=$year-2000;
$age=$data1+$data2;
}
      return $age;
     }
else
  {
   return "false";
  }
}


1;

