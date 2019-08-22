package Ticket_Cancellation;
use RegisterValidation;
use FlightBook;
use strict;
use warnings;
use Term::ANSIColor;
use Text::ANSITable;
use Text::Table;
use Term::ANSIColor 2.00 qw(:pushpop);
my ($name,$class,$age);
my ($dbh,$sth, $driver,$database,$hostname,$dsn,$userid,$password,$sth1,$sth2,$sth3,$sth4,$sth5,$sth6,$sth7);
my ($ID,$Flight_ID,$Flight_Name,$Travel_Place_ID,$Seat_Availability,$Starting_Time,$Destination_Time);
my ($passenger_First_name,$passenger_Last_name,$passenger_email,$passenger_mobile_Number,$type,$passenger_age,$gender,$travel_Date,$boarding_from,$landing_to);
my($email,$mobile_Number,$Id,$Flight_ID1,$Login_ID);
my($from,$to,$date,$id,$count,$ID_);
my ($field1,$field2,$tb);
my($travel_Date1,$boarding_from1,$landing_to1);
my($Flight_Name1,$Starting_Time1,$Destination_Time1,$fromplace_error_checking);
my $object1=new FlightBook();
#getting database connection
$dbh=$FlightBook::self->{dbh};

#ticket_cancellation

sub Ticket_Cancel
{
 $class=shift;
 $id=shift;
 $ID_;
# getting Passenger details fron ID
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
$tb = Text::Table->new(color("on_Blue"),"ID","Flight_ID","Flight_Name","Travel_Date","From","To", "Arraival_Time","Departure_Time","First_Name","Last_Name","Age","Gender","Mobile_Number","Email",color("reset"));

   while (($Login_ID,$Flight_ID,$Flight_Name1,$travel_Date, $boarding_from,$landing_to,$Starting_Time,$Destination_Time,$passenger_First_name,$passenger_Last_name,$passenger_age,$gender,$passenger_mobile_Number,$passenger_email,$id)=$sth1->fetchrow_array())
          {
           $count++;
$tb->add(color("on_Black"),$id,"$Flight_ID","$Flight_Name1","$travel_Date","$boarding_from",   "$landing_to","$Starting_Time","$Destination_Time","$passenger_First_name","$passenger_Last_name","$passenger_age","$passenger_mobile_Number",    "$gender","$passenger_email",color("reset"));
          }
if($count>=1)
{
print color("green"),"View your booking details\n",color("reset");
print "$tb",color("reset");
}
    if($count==0)
      {
       return "No";
      }
# selecting any one of the Listed Passenger details ID
      print color("green"),"Enter the ID\n",color("reset"),;
      $ID_=<STDIN>;
      chomp($ID_);
      $sth1=$dbh->prepare("select Flight_ID,Flight_Name,Travel_Date,Starting_Place,Destination_Place,Arraival_Time,Departure_Time from Passenger_Details where ID=?");
      $sth1->execute($ID_);
      $count=0;

      while(($Flight_ID,$Flight_Name,$travel_Date, $boarding_from,$landing_to,$Starting_Time,$Destination_Time)=$sth1->fetchrow_array())
          {
          
           $Flight_ID1=$Flight_ID;
           $Flight_Name1=$Flight_Name;
           $travel_Date1=$travel_Date;
           $boarding_from1=$boarding_from;
           $landing_to1=$landing_to;
           $Starting_Time1=$Starting_Time;
           $Destination_Time1=$Destination_Time;
           $count++;   
          }

     if($count==0)
        {
         return "Not Available";
        }
  #getting Id,seat availability from Flight_Detais table reference with Travel_Place_Info table
     eval
       {
         $sth1=$dbh->prepare("select ID, Seat_Availability from Flight_Details where Flight_ID=? and Flight_Name=? and Travel_Date=? and Satrting_Time=? and Destination_Time=? and Travel_Place_ID in (select Travel_Place_ID from Travel_Place_Info where Boarding_From =? and Landing_To=?) ");
         $sth1->execute($Flight_ID1,$Flight_Name1,$travel_Date1,$Starting_Time1,$Destination_Time1, $boarding_from1,$landing_to1);
      };
      if($@)
       { 
        return "Error";
       }
      my($ID1,$Seat_Availability1);
      while(($ID,$Seat_Availability)=$sth1->fetchrow_array())
            {
             ($ID1,$Seat_Availability1)=($ID,$Seat_Availability);
            }
     #update seat availability
      eval
      {
     $sth1=$dbh->prepare("update Flight_Details set Seat_Availability='$Seat_Availability1'+1 where ID=?");
     $sth1->execute($ID1);
      };
     if($@)
       { 
        return "Error";
       }
     #cancel the ticket by deleting the Passenger_Details
     eval
      {
     $sth1=$dbh->prepare("Delete from Passenger_Details where ID=?");
     $sth1->execute($ID_);
      };
     if($@)
       { 
        return "Error";
       }
     else
       {
         return "ticket cancelled";
       }
         
}

1;

