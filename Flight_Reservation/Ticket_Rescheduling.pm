package Ticket_Rescheduling;
use RegisterValidation;
use FlightBooking;
use FlightBook;
use strict;
use warnings;
use Term::ANSIColor;
my ($name,$class,$age,$tb,$tb2,$tb1);
my ($dbh,$sth,$sth1,$sth2,$sth3,$sth4,$sth5,$sth6,$sth7);
my ($ID,$Flight_ID,$Flight_Name,$Travel_Place_ID,$Seat_Availability,$Starting_Time,$Destination_Time);
my ($passenger_First_name,$passenger_Last_name,$passenger_email,$passenger_mobile_Number,$type,$passenger_age,$gender,$travel_Date,$boarding_from,$landing_to);
my($email,$mobile_Number,$Id,$Flight_ID1,$Login_ID);
my($from,$to,$date,$id,$error,$error1,$fromplace_error_checking,$toplace_error_checking,$doj_Error_Checking,$passenger_Date_Of_Journey,$availability_error_checking);
my ($field1,$field2,$count);
my($travel_Date1,$boarding_from1,$landing_to1);
my($Flight_Name1,$Starting_Time1,$Destination_Time1,$passenger_First_name1,$passenger_Last_name1,$passenger_mobile_Number1);
my $count5=0;
my $object1=new FlightBook();
$dbh=$FlightBook::self->{dbh};

#Rescheduling
sub Reschedule
  {
   $class=shift;
   $id=shift;
   my $ID_;
   #getting the passenger details by using Login_ID
   eval
   {
    $sth1=$dbh->prepare("select * from Passenger_Details where Login_ID=?");
    $sth1->execute($id);
   };
  if($@)
    {
     return "Error";
    }
   my $count=0;
   #displaying the list of bookings from the Particular Login_ID   
   $tb = Text::Table->new(color("on_yellow"),"ID","Flight_ID","Flight_Name","Travel_Date","From","To", "Arraival_Time","Departure_Time","First_Name","Last_Name","Age","Gender","Mobile_Number","Email",color("reset"));
   while (($Login_ID,$Flight_ID,$Flight_Name,$travel_Date, $boarding_from,$landing_to,$Starting_Time,$Destination_Time,$passenger_First_name,$passenger_Last_name,$passenger_age,$gender,$passenger_mobile_Number,$passenger_email,$id)=$sth1->fetchrow_array())
          {
            $tb->add(color("on_Black"),$id,"$Flight_ID","$Flight_Name","$travel_Date","$boarding_from",   "$landing_to","$Starting_Time","$Destination_Time","$passenger_First_name","$passenger_Last_name","$passenger_age","$passenger_mobile_Number",    "$gender","$passenger_email",color("reset"));
           $count++;
          }
if($count>=1)
{
print "$tb",color("reset");
}

    if($count==0)
      {
       return "No";
      }
   #selecting the particular ID from the list of bookings 
      print color("green"),"Enter the ID\n",color("reset");
      $ID_=<STDIN>;
      chomp($ID_);
     $sth1=$dbh->prepare("select Flight_ID,Flight_Name,Travel_Date,Starting_Place,Destination_Place,Arraival_Time,Departure_Time,First_Name,Last_Name,Mobile_Number from Passenger_Details where ID=?");
     $sth1->execute($ID_);
      $count=0;

     while(($Flight_ID,$Flight_Name,$travel_Date,$boarding_from,$landing_to,$Starting_Time,$Destination_Time,$passenger_First_name,$passenger_Last_name,$passenger_mobile_Number)=$sth1->fetchrow_array())
          {
           #print "$Flight_ID  $Flight_Name  $travel_Date  $boarding_from   $landing_to  $Starting_Time    $Destination_Time\n";      
            $passenger_First_name1=$passenger_First_name;
            $passenger_Last_name1=$passenger_Last_name;
            $passenger_mobile_Number1=$passenger_mobile_Number;
           $Flight_ID1=$Flight_ID;
           $Flight_Name1=$Flight_Name;
           $travel_Date1=$travel_Date;
           $boarding_from1=$boarding_from;
           $landing_to1=$landing_to;
           $Starting_Time1=$Starting_Time;
           $Destination_Time1=$Destination_Time;
           $count++;   
          }
  
     #selecting Id and seat_Availability from flight_Details for updation 
      eval
      {
     $sth3=$dbh->prepare("select ID, Seat_Availability from Flight_Details where Flight_ID=? and Flight_Name=? and Travel_Date=? and Satrting_Time=? and Destination_Time=? and Travel_Place_ID in (select Travel_Place_ID from Travel_Place_Info where Boarding_From =? and Landing_To=?) ");
     $sth3->execute($Flight_ID1,$Flight_Name1,$travel_Date1,$Starting_Time1,$Destination_Time1,$boarding_from1,$landing_to1);
      };
      if($@)
       { 
        return "Error";
       }
     search:
     from:
       print color("green"),"Boarding From\n",color("reset");
       $boarding_from=<STDIN>;
       chomp($boarding_from);
       $fromplace_error_checking=RegisterValidation->NameValidation($boarding_from);
       if($fromplace_error_checking eq "false")
         {
          $error1=$FlightBook::error{'30'};
          print "$error1\n";
          goto from;
         }
       to:
       print color("green"),"Landing To\n",color("reset");
       $landing_to=<STDIN>;
       chomp($landing_to);
       $toplace_error_checking=RegisterValidation->NameValidation($landing_to);
      if($toplace_error_checking eq "false")
        {
         $error1=$FlightBook::error{'30'};
         print "$error1\n";
         goto to;
        }
      DOJ:
      print color("green"),"Enter the Date Of Journey\n",color("reset");
      $passenger_Date_Of_Journey=<STDIN>;
      chomp($passenger_Date_Of_Journey);
      $doj_Error_Checking=RegisterValidation->DOJ($passenger_Date_Of_Journey);
      if($doj_Error_Checking eq "1")
        {
          $error1=$FlightBook::error{'8'};
          print "$error1\n";
          goto DOJ;
        }
      if($doj_Error_Checking eq "2")
        {
          $error1=$FlightBook::error{'9'};
          print "$error1\n";
          goto DOJ;
        }
      if($doj_Error_Checking eq "3")
        {
          $error1=$FlightBook::error{'10'};
           print "$error1\n";
           goto DOJ;
        }
      if($doj_Error_Checking eq "4")
        {
            $error1=$FlightBook::error{'11'};
            print "$error1\n";
            goto DOJ;
         }
       if($doj_Error_Checking eq "5")
         {
           $error1=$FlightBook::error{'12'};
           print "$error1\n";
           goto DOJ;
         }
       if($doj_Error_Checking eq "false")
         {
           $error1=$FlightBook::error{'13'};
           print "$error1\n";
           goto DOJ;
         }
      $availability_error_checking=FlightBooking->Availability($boarding_from,$landing_to,$passenger_Date_Of_Journey);
       if($availability_error_checking eq "Error")
        {
         $error1=$FlightBook::error{'26'};
         print color("red"),"$error1\n",color("reset");
         goto search;
        }
      elsif($availability_error_checking eq "No")
       {
        $error1=$FlightBook::error{'7'};
        print color("red"),"$error1\n",color("reset");
        goto search;
       }
     elsif($availability_error_checking eq "flights not available")
       {
        $error1=$FlightBook::error{'31'};
        print color("red"),"you cannot reschedule your booked flights because booking has closed for $boarding_from to $landing_to\n",color("reset");
        
        goto search;
       }
      elsif($availability_error_checking eq "not available")
       {
        $error1=$FlightBook::error{'27'};
        print color("red"),"$error1 for $boarding_from to $landing_to\n",color("reset");
        goto search;
       }
      else
       {
         $Flight_ID1=$availability_error_checking;
       }
      # selectingthe updation details
      eval
       {
         $sth2=$dbh->prepare("select Id,Seat_Availability,Flight_Name,Arraival_Time,Departure_Time from Flight_Availability where Flight_ID=?");
         $sth2->execute($Flight_ID1);
       };
      if($@)
        {
         return "Error";
        }
    while(($field1,$field2,$Flight_Name,$Starting_Time,$Destination_Time) = $sth2->fetchrow_array())
         { 
          $Id=$field1;
          $sth4=$field2;
          $Flight_Name1=$Flight_Name;
          $Starting_Time1=$Starting_Time;
          $Destination_Time1=$Destination_Time;
         }
      #checking the booking status
$count5=0;
 $sth1=$dbh->prepare("select * from Passenger_Details where Travel_Date=? and Starting_Place=? and Destination_Place=? and First_Name=? and Last_Name=? and Mobile_Number=?");
$sth1->execute($passenger_Date_Of_Journey,$boarding_from,$landing_to,$passenger_First_name1,$passenger_Last_name1,$passenger_mobile_Number1);
     while($sth1->fetch)
       {
         $count5++;
       }
     if($count5>=1)
       {
        return "already exist";
       }
     #rescheduling
      eval
       {
        $sth2=$dbh->prepare("update Passenger_Details set Flight_ID=?,Flight_Name=?,Travel_Date=?,Starting_Place=?,Destination_Place=?,Arraival_Time=?,Departure_Time=? where ID=?");
        $sth2->execute($Flight_ID1,$Flight_Name1,$passenger_Date_Of_Journey,$boarding_from,$landing_to,$Starting_Time1,$Destination_Time1,$ID_);
      };
     if($@)
       { 
        return "Error";
       }
    eval
      {
       $sth1=$dbh->prepare("update Flight_Details set Seat_Availability='$sth4'-1 where ID=?");
       $sth1->execute($Id);
      };
    if($@)
      {
       return "Error";
      }
       $sth1=$dbh->prepare("drop table Flight_Availability"); 
       $sth1->execute();
     my($ID1,$Seat_Availability1);
     while(($ID,$Seat_Availability)=$sth3->fetchrow_array())
        {
           ($ID1,$Seat_Availability1)=($ID,$Seat_Availability);
        }
   eval
      {
     $sth4=$dbh->prepare("update Flight_Details set Seat_Availability='$Seat_Availability1'+1 where ID=?");
     $sth4->execute($ID1);
     };
     if($@)
       {
        return "Error";
       }
   if($count==0)
     {
       return "No Booking";
     }
   else
      {
       return "Ticket Rescheduled";
      }    
}
sub ViewAll
{
$class=shift;
$id=shift;
#displaying all the Passenger_Details of given Login_ID
eval
 {
  $sth1=$dbh->prepare("select * from Passenger_Details where Login_ID=?");
  $sth1->execute($id);
 };
 if($@)
   {
    return "Error";
   }
 $count=0; 
 print color("cyan"),"Passenger Details\n",color("reset");
#displaying all the details
 $tb1 = Text::Table->new(color("on_yellow"),"ID","Flight_ID","Flight_Name","Travel_Date","From","To", "Arraival_Time","Departure_Time","First_Name","Last_Name","Age","Gender","Mobile_Number","Email",color("reset"));
   while (($Login_ID,$Flight_ID,$Flight_Name,$travel_Date, $boarding_from,$landing_to,$Starting_Time,$Destination_Time,$passenger_First_name,$passenger_Last_name,$passenger_age,$gender,$passenger_mobile_Number,$passenger_email,$id)=$sth1->fetchrow_array())
          {
           $tb1->add(color("on_Black"),$id,"$Flight_ID","$Flight_Name","$travel_Date","$boarding_from",   "$landing_to","$Starting_Time","$Destination_Time","$passenger_First_name","$passenger_Last_name","$passenger_age","$passenger_mobile_Number",    "$gender","$passenger_email",color("reset"));
           $count++;
          }
if($count>=1)
{
print "$tb1",color("reset");
}
if($count==0)
{
return "null";
}
else
{
return "true";
}

}

# search the booking by using name and mobile number
sub Search
{
 $class=shift;
 $id=shift;
 $name=shift;
 $mobile_Number=shift;
eval
  {
   $sth4=$dbh->prepare("select * from Passenger_Details where Login_ID=? and First_Name like '%$name%' and Mobile_Number=?");
  $sth4->execute($id,$mobile_Number);
 };
if($@)
   {
    return "Error";
   }
eval
  {
   $sth5=$dbh->prepare("select * from Passenger_Details where Login_ID=? and First_Name like '%$name%' and Mobile_Number=?");
  $sth5->execute($id,$mobile_Number);
 };
if($@)
   {
    return "Error";
   }

my $count3=0;
 while($sth4->fetch)
         { 
$count3++;
         }
if($count3==0)
{
return"not available";
}
if($count3>0)
{
$tb2 = Text::Table->new(color("on_yellow"),"ID","Flight_ID","Flight_Name","Travel_Date","From","To", "Arraival_Time","Departure_Time","First_Name","Last_Name","Age","Gender","Mobile_Number","Email",color("reset"));
while(($Login_ID,$Flight_ID,$Flight_Name,$travel_Date, $boarding_from,$landing_to,$Starting_Time,$Destination_Time,$passenger_First_name,$passenger_Last_name,$passenger_age,$gender,$passenger_mobile_Number,$passenger_email,$ID) = $sth5->fetchrow_array())
         { 
          $tb2->add(color("on_Black"),$id,"$Flight_ID","$Flight_Name","$travel_Date","$boarding_from",   "$landing_to","$Starting_Time","$Destination_Time","$passenger_First_name","$passenger_Last_name","$passenger_age","$passenger_mobile_Number",    "$gender","$passenger_email",color("reset"));
         }
print "$tb2",color("reset");
return "true";
}
else
{ 
return "not available";
}
}

