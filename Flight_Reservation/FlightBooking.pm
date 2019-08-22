package FlightBooking;
use RegisterValidation;
use FlightBook;
use BookingEntity;
use strict;
use warnings;
use Term::ANSIColor;
my ($name,$class,$age,$tb);
my ($dbh,$sth, $driver,$database,$hostname,$dsn,$userid,$password,$sth1,$sth2,$sth3,$sth4,$sth5,$sth6,$sth7);
my ($ID,$Flight_ID,$Flight_Name,$Travel_Place_ID,$Seat_Availability,$Starting_Time,$Destination_Time);
my ($passenger_First_name,$passenger_Last_name,$passenger_email,$passenger_mobile_Number,$type,$passenger_age,$gender,$travel_Date,$boarding_from,$landing_to);
my($email,$mobile_Number,$Id,$Flight_ID1,$Login_ID);
my($from,$to,$date,$id);
my ($field1,$field2);
my($travel_Date1,$boarding_from1,$landing_to1);
my($Flight_Name1,$Starting_Time1,$Destination_Time1);
my $object1=new FlightBook();
my $object2=new BookingEntity();
$dbh=$FlightBook::self->{dbh};
#checking the flight availability 
sub Availability
 {
  $class=shift;
  $from=shift;
  $to=shift;
  $date=shift;
my $count=0;
 # checking the availability from Flight_Availability table
  eval
  {
   $sth =$FlightBook::self->{Flight_Avai};
   $sth->execute($from,$to,$date);
  };
 if($@)
   {
    return "not available";
   }
while($sth->fetch)
{
$count++;
}
if($count==0)
{
return "not available";
}
 #creating the Flight_Availability table
  eval
   {
    $sth1=$FlightBook::self->{Flight_Avai_Table};
    $sth1->execute();
  };
 if($@)
   {
    return "Error";
   }
 $count=0;    
# execution for checking Flight_Availability 
 
    eval
  {
   $sth =$FlightBook::self->{Flight_Avai};
   $sth->execute($from,$to,$date);
  };
  if($@)
   {
    return "Error";
   }
$tb = Text::Table->new(color("on_Blue"),"ID","Flight_ID","Flight_Name","Travel_Place_ID","Seat_Availability","Arraival_Time","Departure_Time",color("reset"));
while (($Flight_ID,$Flight_Name,$Travel_Place_ID,$Seat_Availability,$Starting_Time,$Destination_Time,$ID)=                 $sth->fetchrow_array())
       {
        if($Seat_Availability gt 0)
           {
            $tb->add(color("on_Black"),$ID,"$Flight_ID","$Flight_Name","$Travel_Place_ID","$Seat_Availability","$Starting_Time","$Destination_Time",color("reset"));
            $sth1=$FlightBook::self->{Insert_Flight_Availability};
            $sth1->execute($ID,$Flight_ID,$Flight_Name,$Travel_Place_ID,$Seat_Availability,$Starting_Time,$Destination_Time);
            $count++;
           }
       }
 if($count==0)
    {
      return "flights not available";
    }
else
{
  print "$tb",color("reset");
}
      again:
      $count=0;
      print color("green"),"Enter the Flight_ID\n",color("reset");
      $Flight_ID1=<STDIN>;
      chomp($Flight_ID1);
      $sth1=$FlightBook::self->{select_Flight_Availability};
      $sth1->execute($Flight_ID1);
      while($sth1->fetch)
      {
       $count++;
      }
     if($count>=1)
       {
        return $Flight_ID1;
       }
     else
       {
          goto again;
       }
    }

#Booking process under the Book subroutine

sub Book
{ 
  $class=shift;
  $id=shift;
  $passenger_First_name=shift;
  $passenger_Last_name=shift;
  $passenger_age=shift;
  $gender=shift;
  $travel_Date=shift;
  $passenger_mobile_Number=shift;
  $passenger_email=shift;
  $boarding_from=shift;
  $landing_to=shift;
  $Flight_ID1=shift;

  # checking the flight availability from Flight_Availability table
  eval
  {
  $sth2=$FlightBook::self->{check_ID_from_Flight_Availability};
  $sth2->execute($Flight_ID1);
  };
  if($@)
    {
    return "Error";
    }
  while(($field1,$field2,$Flight_Name,$Starting_Time,$Destination_Time) = $sth2->fetchrow_array())
       {
        $sth4=$field2;
        $Flight_Name1=$Flight_Name;
        $Starting_Time1=$Starting_Time;
         $Destination_Time1=$Destination_Time;
       }
  #checking the booking status
  eval
   {
    $sth5=$FlightBook::self->{Booking_Status};
    $sth5->execute($Flight_ID1,$Flight_Name1,$passenger_First_name,$travel_Date,$passenger_mobile_Number);
   };
   if($@)
     {
       print "Error";
     }
   my $count1=0;
   while($sth5->fetch)
        {
         $count1++;
        }
   if($count1==0)
     {
     #insert datas into the Passenger_Details
   eval
      {
       $sth6=$FlightBook::self->{Insert_Passenger_Details};
       $sth6->execute($id,$Flight_ID1,$Flight_Name1,$travel_Date, $boarding_from,$landing_to,$Starting_Time1,$Destination_Time1,$passenger_First_name,$passenger_Last_name,$passenger_age,$gender,$passenger_mobile_Number,$passenger_email);
     };
   if($@)
     {
      return "Error1";
     }
   #after booking update the seat_availability 
   eval
     {
      $sth3=$dbh->prepare("update Flight_Details set Seat_Availability='$sth4'-1 where ID in (select Id from  Flight_Availability where Flight_Id=?)"); 
      $sth3->execute($Flight_ID1);
     };
   if($@)
     {
      return "Error";
     }
   #droping the flight availability table
     $sth1=$dbh->prepare("drop table Flight_Availability"); 
     $sth1->execute();
     return "true";
    }
  elsif($count1>0)
    {
      return "Already_Booked";
    }
 }


1;

