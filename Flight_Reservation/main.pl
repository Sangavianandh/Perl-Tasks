use strict;
use warnings;
use Term::ANSIColor;
use RegisterValidation;
use FlightBooking;
use FlightBook;
use Ticket_Rescheduling;
use Ticket_Cancellation;
my $object=RegisterValidation::Connection();
my ($error,$error1,$name,$name_error_checking,$email,$email_error_checking,$mobile_Number,$mobile_num_error_checking,$login_error_checking,$register_error_checking,$passenger_Date_Of_Birth,$dob_Error_Checking,$passenger_First_Name,$passenger_Last_Name,$doj_Error_Checking,$passenger_Date_Of_Journey,$boarding_from,$fromplace_error_checking,$landing_to,$toplace_error_checking,$availability_error_checking,$type,$type1,$Id,$id,$age,$gender,$Booking_error_checking,$Flight_ID1,$view_Details,$reschedule_Error_Checking,$help,$sth1);
my $dbh=$FlightBook::self->{dbh};
  if($object eq "false")
   {
    $error=$FlightBook::error{'1'};
    print "$error\n";
    exit;
   }
 else
   {
    print color("yellow"),"Database Connected\n\n\n\n",color("reset");
   }

  print "press 'h' or 'H' for help \n";
  print "press 'c' or 'C' for contineue \n";
  $help=<STDIN>;
  if($help =~ /H/i)
    {
     my $filename = 'useage.txt';
     open(my $fh, '<:encoding(UTF-8)', $filename)
     or die "Could not open file '$filename' $!";
     while(my $row = <$fh>)
         {
          chomp $row;
          print "$row\n";
         }
    }
elsif($help =~ /[C]/i)
{
goto again;
}
else
{
exit;
}
 again:
 print color("cyan"),"1.Login\t\t2.Register\n",color("reset");
 print color("Blue"),"Enter Your Choice\n",color("reset");
 my $input=<STDIN>;
 chomp($input);
 if($input =~ /^[0-9]/)
  {
   #login
   if($input==1)
    {
     print color("yellow"), "Welcome!!!\n", color("reset");
     Id:
     print color("green"),"Enter the Login_Id\n",color("reset");
     $id=<STDIN>;
     chomp($id);
     unless($id =~ /^[0-9]/)
      {
       $error1=$FlightBook::error{'3'};
       print color("red"),"$error1\n",color("reset");
       goto Id;
      }
    name:
    print color("green"),"Enter the name\n",color("reset");
    $name=<STDIN>;
    chomp($name);
    $name_error_checking=RegisterValidation->NameValidation($name);
    if($name_error_checking eq "false")
      {
       $error1=$FlightBook::error{'4'};
       print color("red"),"$error1\n",color("reset");
       goto name;
      }
     mobile_number:
     print color("green"),"Enter Mobile Number\n",color("reset"),;
     $mobile_Number=<STDIN>;
     chomp($mobile_Number);
     $mobile_num_error_checking=RegisterValidation->MobileValidation($mobile_Number);
     if($mobile_num_error_checking eq "false")
       {
        $error1=$FlightBook::error{'6'};
        print color("red"),"$error1\n",color("reset");
        goto mobile_number;
       }
     my $login_error_checking=RegisterValidation->LoginData($id,$name,$mobile_Number);
     if($login_error_checking eq "true")
       {
        print color("blue"),"Login successfully\n",color("reset");
       }
    elsif($login_error_checking eq "Error")
       {
        $error1=$FlightBook::error{'20'};
        print color("red"),"$error1\n",color("reset");
        goto again;
       }
     elsif($login_error_checking eq "false")
      {
       $error1=$FlightBook::error{'28'};
        print color("red"),"$error1\n",color("reset");
        goto again;
      }
     elsif($login_error_checking eq "register")
      {
       $error1=$FlightBook::error{'29'};
        print color("red"),"$error1\n",color("reset");
        goto again;
      }
   
   }
#Register
 elsif($input==2)
   {
    name1:
    print color("green"),"Enter the name\n",color("reset");
    $name=<STDIN>;
    chomp($name);
    $name_error_checking=RegisterValidation->NameValidation($name);
     if($name_error_checking eq "false")
       {
        $error1=$FlightBook::error{'4'};
        print color("red"),"$error1\n",color("reset");
        goto name1;
       }
     email1:
     print color("green"),"Enter e-mail\n",color("reset");
     $email=<STDIN>;
     chomp($email);
     $email_error_checking=RegisterValidation->EmailValidation($email);
     if($email_error_checking eq "false")
        {
         $error1=$FlightBook::error{'5'};
         print color("red"),"$error1\n",color("reset");
         goto email1;
        }
     mobile_number1:
     print color("green"),"Enter Mobile Number\n",color("reset");
     $mobile_Number=<STDIN>;
     chomp($mobile_Number);
     $mobile_num_error_checking=RegisterValidation->MobileValidation($mobile_Number);
     if($mobile_num_error_checking eq "false")
       {
        $error1=$FlightBook::error{'6'};
        print color("red"),"$error1\n",color("reset");
        goto mobile_number1;
       }
      $register_error_checking=RegisterValidation->RegisterData($name,$email,$mobile_Number);
    if($register_error_checking eq "duplicate")
        {
         $error1=$FlightBook::error{'8'};
         print color("red"),"$error1\n",color("reset");
         goto again;
        }
    else
       {
         $id=$register_error_checking;
         print color("blue"),"$name!! you had registered successfully\n",color("reset");
         print "$id";
       }
     }
   else
    {
     $error1=$FlightBook::error{'19'};
     print color("red"),"$error1\n",color("reset");
     goto again;
    }
  }
 else
  {
   $error1=$FlightBook::error{'3'};
   print color("red"),"$error1\n",color("reset");
   goto again;
  }
 #Booking
 Book:
 print color("cyan"),"1.Book\t\t2.Reschudule\t\t3.Cancel\t\t4.Search\t\t5.Logout\n",color("reset");
 $type=<STDIN>;
 chomp($type);
choose:
 if($type==1)
   {
    print color("blue"),"1.Manual Booking\t\t2.Quick Booking\n",color("reset");
    print color("yellow"),"press M or m for Manual Booking\n",color("reset");
    print color("yellow"),"press q or Q for Quick Booking\n",color("reset");
    $type1=<STDIN>;
    chomp($type1);
    if($type1 =~ /[M]/i)
      {
       from:
       print color("green"),"Boarding From\n",color("reset");
       $boarding_from=<STDIN>;
       chomp($boarding_from);
       $fromplace_error_checking=RegisterValidation->NameValidation($boarding_from);
       if($fromplace_error_checking eq "false")
         {
          $error1=$FlightBook::error{'4'};
          print color("red"),"$error1\n",color("reset");
          goto from;
         }
       to:
       print color("green"),"Landing To\n",color("reset");
       $landing_to=<STDIN>;
       chomp($landing_to);
       $toplace_error_checking=RegisterValidation->NameValidation($landing_to);
      if($toplace_error_checking eq "false")
        {
         $error1=$FlightBook::error{'4'};
         print color("red"),"$error1\n",color("reset");
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
          print color("red"),"$error1\n",color("reset");
          goto DOJ;
        }
      if($doj_Error_Checking eq "2")
        {
          $error1=$FlightBook::error{'9'};
          print color("red"),"$error1\n",color("reset");
          goto DOJ;
        }
      if($doj_Error_Checking eq "3")
        {
          $error1=$FlightBook::error{'10'};
          print color("red"),"$error1\n",color("reset");
          goto DOJ;
        }
      if($doj_Error_Checking eq "4")
        {
            $error1=$FlightBook::error{'11'};
            print color("red"),"$error1\n",color("reset");
            goto DOJ;
         }
       if($doj_Error_Checking eq "5")
         {
           $error1=$FlightBook::error{'12'};
           print color("red"),"$error1\n",color("reset");
           goto DOJ;
         }
       if($doj_Error_Checking eq "false")
         {
           $error1=$FlightBook::error{'13'};
           print color("red"),"$error1\n",color("reset");
           goto DOJ;
         }
       $availability_error_checking=FlightBooking->Availability($boarding_from,$landing_to,$passenger_Date_Of_Journey);      
     if($availability_error_checking eq "Error")
       {
        $error1=$FlightBook::error{'26'};
        print color("red"),"$error1\n",color("reset");
        goto choose;
       }
      if($availability_error_checking eq "No")
       {
        $error1=$FlightBook::error{'7'};
        print color("red"),"$error1\n",color("reset");
        goto choose;
       }
     elsif($availability_error_checking eq "flights not available")
       {
        $error1=$FlightBook::error{'27'};
        print color("red"),"Booking Finished. $error1\n",color("reset");
        goto choose;
       }
      elsif($availability_error_checking eq "not available")
       {
        $error1=$FlightBook::error{'27'};
        print color("red"),"$error1 for $boarding_from to $landing_to\n",color("reset");
        goto choose;
       }
       elsif($availability_error_checking eq "not available1")
       {
        $error1=$FlightBook::error{'26'};
        print color("red"),"$error1\n",color("reset");
        goto choose;
       }
      else
       {
         $Flight_ID1=$availability_error_checking;
       }
     First_Name:
     print color("green"),"Enter the First_Name\n",color("reset");
     $passenger_First_Name=<STDIN>;
     chomp($passenger_First_Name);
     $name_error_checking=RegisterValidation->NameValidation($passenger_First_Name);
     if($name_error_checking eq "false")
       {
        $error1=$FlightBook::error{'4'};
        print color("red"),"$error1\n",color("reset");
        goto First_Name;
       }
     Last_Name:
     print color("green"),"Enter the Last_Name\n",color("reset");
     $passenger_Last_Name=<STDIN>;
     chomp($passenger_Last_Name);
     $name_error_checking=RegisterValidation->NameValidation($passenger_Last_Name);
     if($name_error_checking eq "false")
       {
        $error1=$FlightBook::error{'4'};
        print color("red"),"$error1\n",color("reset");
        goto Last_Name;
       }
     DOB:
     print color("green"),"Enter the Date Of Birth\n",color("reset");
     $passenger_Date_Of_Birth=<STDIN>;
     chomp($passenger_Date_Of_Birth);
     $dob_Error_Checking=RegisterValidation->DOB($passenger_Date_Of_Birth);
     if($dob_Error_Checking eq "1")
       {
         $error1=$FlightBook::error{'8'};
         print color("red"),"$error1\n",color("reset");
         goto DOB;
       }
     if($dob_Error_Checking eq "2")
       {
        $error1=$FlightBook::error{'9'};
        print color("red"),"$error1\n",color("reset");
        goto DOB;
       }
     if($dob_Error_Checking eq "3")
       {
        $error1=$FlightBook::error{'10'};
        print color("red"),"$error1\n",color("reset");
        goto DOB;
       }
     if($dob_Error_Checking eq "4")
       {
        $error1=$FlightBook::error{'11'};
        print color("red"),"$error1\n",color("reset");
        goto DOB;
       }
     if($dob_Error_Checking eq "5")
       {
        $error1=$FlightBook::error{'14'};
        print color("red"),"$error1\n",color("reset");
        goto DOB;
       }
     if($dob_Error_Checking eq "false")
       {
        $error1=$FlightBook::error{'13'};
        print color("red"),"$error1\n",color("reset");
        goto DOB;
       }
     else
       {
        $age=$dob_Error_Checking;
       }
    Gender:
    print color("green"),"Enter the Gender\n",color("reset");
    $gender=<STDIN>;
    chomp($gender);
    $name_error_checking=RegisterValidation->GenderValidation($gender);
    if($name_error_checking eq "false")
      {
       $error1=$FlightBook::error{'23'};
       print color("red"),"$error1\n",color("reset");
       goto Gender;
      }
     mobile_number1:
     print color("green"),"Enter Mobile Number\n",color("reset");
     $mobile_Number=<STDIN>;
     chomp($mobile_Number);
     $mobile_num_error_checking=RegisterValidation->MobileValidation($mobile_Number);
     if($mobile_num_error_checking eq "false")
       {
        $error1=$FlightBook::error{'6'};
        print color("red"),"$error1\n",color("reset");
        goto mobile_number1;
       }
     type3:
     print color("yellow"),"Do you want to enroll email?\n",color("reset");
     print color("yellow"),"press Y or y for yes\n",color("reset");
     print color("yellow"),"press N or n for no\n",color("reset");
     my $type3=<STDIN>;
     chomp($type3);
     if($type3=~/[A-Za-z]/)
       {
       if($type3 =~/[Y]/i)
         {
          email1:
          print color("green"),"Enter e-mail\n",color("reset");
          $email=<STDIN>;
          chomp($email);
          $email_error_checking=RegisterValidation->EmailValidation($email);
          if($email_error_checking eq "false")
            {
             $error1=$PhoneBook::error{'4'};
             print color("red"),"$error1\n",color("reset");
             goto email1;
            }
         }
     elsif($type3=~/[n]/i)
          {
           $email="null";
          }
        else
          {
           print color("red"),"Please enter the correct choioce",color("reset");
           goto type3;
          }
        }
     else
      {
        $error1=$PhoneBook::error{'16'};
        print color("red"),"$error1\n",color("reset");
        goto type3;
      }
       my $object1 = new BookingEntity($id,$passenger_First_Name,$passenger_Last_Name,$age,$gender,$email);
       $Booking_error_checking=FlightBooking->Book($id,$passenger_First_Name,$passenger_Last_Name,$age,$gender,   $passenger_Date_Of_Journey,$mobile_Number,$email,$boarding_from,$landing_to,$Flight_ID1,$type3);
       if($Booking_error_checking eq "Error")
         {
           $error1=$FlightBook::error{'26'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
         if($Booking_error_checking eq "Error")
         {
           $error1=$FlightBook::error{'25'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       elsif($Booking_error_checking eq "Already_Booked")
         {
           $error1=$FlightBook::error{'17'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       else
         {
           $error1=$FlightBook::error{'18'};
           print color("yellow"),"$error1\n",color("reset");
         }
       Decide:
       print color("yellow"),"Do you want to continue Booking?\n",color("reset");
       print color("yellow"),"y or Y to contineue booking\n",color("reset");
       print color("yellow"),"N or n to stop\n",color("reset");
       my $result=<STDIN>;
       if($result=~/[Y]/i)
         {
          goto Book;
         }
        elsif($result=~/[N]/i)
          {
            exit;
          }
         else
          {
            print color("red"),"No such choices are available\n",color("reset");
            goto Decide;
          } 
    }
   elsif($type1 =~/[Q]/i)
      {
      Quick_book:
      print color("yellow"),"Enter the Passenger_details\n",color("reset");
       $boarding_from=<STDIN>;
      chomp($boarding_from);
       $landing_to=<STDIN>;
      chomp($landing_to);
       $passenger_Date_Of_Journey=<STDIN>;
      chomp($passenger_Date_Of_Journey);
       $passenger_First_Name=<STDIN>;
      chomp($passenger_First_Name);
       $passenger_Last_Name=<STDIN>;
      chomp($passenger_Last_Name);
       $passenger_Date_Of_Birth=<STDIN>;
      chomp($passenger_Date_Of_Birth);
       $gender=<STDIN>;
      chomp($gender);
       $mobile_Number=<STDIN>;
      chomp($mobile_Number);
       $email=<STDIN>;
      chomp($email);
       $fromplace_error_checking=RegisterValidation->NameValidation($boarding_from);
       if($fromplace_error_checking eq "false")
         {
          $error1=$FlightBook::error{'4'};
          print color("red"),"$error1\n",color("reset");
          goto Quick_book;
         }
       $toplace_error_checking=RegisterValidation->NameValidation($landing_to);
      if($toplace_error_checking eq "false")
        {
         $error1=$FlightBook::error{'4'};
         print color("red"),"$error1\n",color("reset");
         goto Quick_book;
        }
      $doj_Error_Checking=RegisterValidation->DOJ($passenger_Date_Of_Journey);
      if($doj_Error_Checking eq "1")
        {
          $error1=$FlightBook::error{'8'};
          print color("red"),"$error1\n",color("reset");
          goto Quick_book;
        }
      if($doj_Error_Checking eq "2")
        {
          $error1=$FlightBook::error{'9'};
          print color("red"),"$error1\n",color("reset");
          goto Quick_book;
        }
      if($doj_Error_Checking eq "3")
        {
           $error1=$FlightBook::error{'10'};
           print color("red"),"$error1\n",color("reset");
           goto Quick_book;
        }
      if($doj_Error_Checking eq "4")
        {
            $error1=$FlightBook::error{'11'};
            print color("red"),"$error1\n",color("reset");
            goto Quick_book;
         }
       if($doj_Error_Checking eq "5")
         {
           $error1=$FlightBook::error{'12'};
           print color("red"),"$error1\n",color("reset");
           goto Quick_book;
         }
       if($doj_Error_Checking eq "false")
         {
           $error1=$FlightBook::error{'13'};
           print color("red"),"$error1\n",color("reset");
           goto Quick_book;
         }
     $name_error_checking=RegisterValidation->NameValidation($passenger_First_Name);
     if($name_error_checking eq "false")
       {
        $error1=$FlightBook::error{'4'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
     $name_error_checking=RegisterValidation->NameValidation($passenger_Last_Name);
     if($name_error_checking eq "false")
       {
        $error1=$FlightBook::error{'4'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }     
     $dob_Error_Checking=RegisterValidation->DOB($passenger_Date_Of_Birth);
     if($dob_Error_Checking eq "1")
       {
         $error1=$FlightBook::error{'8'};
         print "$error1\n";
         goto Quick_book;
       }
     if($dob_Error_Checking eq "2")
       {
        $error1=$FlightBook::error{'9'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
     if($dob_Error_Checking eq "3")
       {
        $error1=$FlightBook::error{'10'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
     if($dob_Error_Checking eq "4")
       {
        $error1=$FlightBook::error{'11'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
     if($dob_Error_Checking eq "5")
       {
        $error1=$FlightBook::error{'14'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
     if($dob_Error_Checking eq "false")
       {
        $error1=$FlightBook::error{'13'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
     else
       {
        $age=$dob_Error_Checking;
       }
    $name_error_checking=RegisterValidation->GenderValidation($gender);
    if($name_error_checking eq "false")
      {
       $error1=$FlightBook::error{'23'};
       print color("red"),"$error1\n",color("reset");
       goto Quick_book;
      }
     $mobile_num_error_checking=RegisterValidation->MobileValidation($mobile_Number);
     if($mobile_num_error_checking eq "false")
       {
        $error1=$FlightBook::error{'6'};
        print color("red"),"$error1\n",color("reset");
        goto Quick_book;
       }
        if($email eq "")
         {
          $email="null";
         }
      else
      {
       $email_error_checking=RegisterValidation->EmailValidation($email);
        if($email_error_checking eq "false")
          {
           $error1=$FlightBook::error{'4'};
           print color("red"),"$error1\n",color("reset");
          } 
      }
    $availability_error_checking=FlightBooking->Availability($boarding_from,$landing_to,$passenger_Date_Of_Journey);
      if($availability_error_checking eq "Error")
       {
        $error1=$FlightBook::error{'26'};
        print color("red"),"$error1\n",color("reset");
        goto Book;
       }
      if($availability_error_checking eq "No")
       {
        $error1=$FlightBook::error{'7'};
        print color("red"),"$error1\n",color("reset");
        goto Book;
       }
      if($availability_error_checking eq "not available")
       {
        $error1=$FlightBook::error{'27'};
        print color("red"),"$error1\n",color("reset");
        goto Book;
       }
      else
       {
         $Flight_ID1=$availability_error_checking;
       }

       #my $object1 = new BookingEntity($id,$passenger_First_Name,$passenger_Last_Name,$age,$gender,$email);
       $Booking_error_checking=FlightBooking->Book($id,$passenger_First_Name,$passenger_Last_Name,$age,$gender,   $passenger_Date_Of_Journey,$mobile_Number,$email,$boarding_from,$landing_to,$Flight_ID1);
       if($Booking_error_checking eq "Error")
         {
           $error1=$FlightBook::error{'7'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       elsif($Booking_error_checking eq "Already_Booked")
         {
           $error1=$FlightBook::error{'17'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       else
         {
           $error1=$FlightBook::error{'18'};
           print color("red"),"$error1\n",color("reset");
         }
       Decide:
       print color("yellow"),"Do you want to continue Booking?\n",color("reset");
       print color("yellow"),"y or Y to contineue booking\n",color("reset");
       print color("yellow"),"N or n to stop\n",color("reset");
       my $result=<STDIN>;
       if($result=~/[Y]/i)
         {
          goto Book;
         }
        elsif($result=~/[N]i/)
          {
            exit;
          }
         else
          {
            print color("red"),"No such choices are available\n",color("reset");
            goto Decide;
          } 

  }
 }
#Ticket_Reschedule
elsif($type==2)
     {
      $reschedule_Error_Checking=Ticket_Rescheduling->Reschedule($id);
      $sth1=$dbh->prepare("drop table Flight_Availability"); 
      $sth1->execute();
       if($reschedule_Error_Checking eq "Error")
         {
           $error1=$FlightBook::error{'7'};
           print color("red"),"$error1\n",color("reset");
         }
       if($reschedule_Error_Checking eq "No")
         {
           $error1=$FlightBook::error{'22'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       elsif($reschedule_Error_Checking eq "already exist")
         {
           $error1=$FlightBook::error{'17'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       elsif($reschedule_Error_Checking eq "flights not available")
       {
        $error1=$FlightBook::error{'31'};
        print color("red"),"$error1\n",color("reset");
        print color("bold red"),"$availability_error_checking\n",color("reset");
        goto Book;
       }
       else
         {
           $error1=$FlightBook::error{'24'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
      }
#Ticket_Cancellation
elsif($type==3)
{
$view_Details=Ticket_Cancellation->Ticket_Cancel($id);
      if($view_Details eq "Error")
         {
           $error1=$FlightBook::error{'7'};
           print color("red"),"$error1\n",color("reset");
         }
       if($view_Details eq "ticket cancelled")
         {
           $error1=$FlightBook::error{'21'};
           print color("red"),"$error1\n",color("reset");
           goto Book; 
         }
       else
         {
           $error1=$FlightBook::error{'22'};
           print "$error1\n";
           goto Book;
         }

}
#Search
elsif($type==4)
{
   my $viewall=Ticket_Rescheduling->ViewAll($id);
if($viewall ne "null")
{
     Name1:
     print color("green"),"Enter Name\n",color("reset");
     $passenger_First_Name=<STDIN>;
     chomp($passenger_First_Name);
     $name_error_checking=RegisterValidation->NameValidation($passenger_First_Name);
     if($name_error_checking eq "false")
       {
        $error1=$FlightBook::error{'4'};
        print color("red"),"$error1\n",color("reset");
        goto Name1;
       } 
     Mobile_number1:
     print color("green"),"Enter Mobile Number\n",color("reset");
     $mobile_Number=<STDIN>;
     chomp($mobile_Number);
     $mobile_num_error_checking=RegisterValidation->MobileValidation($mobile_Number);
     if($mobile_num_error_checking eq "false")
       {
        $error1=$FlightBook::error{'6'};
        print color("red"),"$error1\n",color("reset");
        goto Mobile_number1;
       }
      $view_Details=Ticket_Rescheduling->Search($id,$passenger_First_Name,$mobile_Number);
       if($view_Details eq "not available")
         {
           $error1=$FlightBook::error{'22'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       if($view_Details eq "No Booking")
         {
           $error1=$FlightBook::error{'21'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
         }
       else
         {
          goto Book;
         }
}
else
{
 $error1=$FlightBook::error{'22'};
           print color("red"),"$error1\n",color("reset");
           goto Book;
}
}

#logout
elsif($type==5)
    {
     exit;
    }


