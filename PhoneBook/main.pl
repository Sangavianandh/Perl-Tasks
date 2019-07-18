use strict;
use warnings;
use Validation;
use PhoneBook;
my $object=Validation::Connection();
  if($object eq "false")
   {
    my $error=$PhoneBook::error{'5'};
    print "$error\n";
    exit;
   }
 else
   {
  print "Database Connected\n\n\n\n";
   }
my ($update1,$update,$update2,$count,$name_error_checking,$mobile_num_error_checking,$email_error_checking,$data_error_checking,$sth,$listing_data,$delete_row,$update_data_error_checking);
my ($father_Name,$address,$mother_Name,$mobile_Number,$gender,$email,$citizen_Number,$input,$name,$error1);

print "\t\t\t\t\t\t\t************WELCOME TO PHONE BOOK************\t\t\n";
label:
print "\n\t\t\t\t\t\t\t\t\t\tMenu\t\t\t\n\n";
print "\t\t\t\t\t\t\t\t1.Add New            2.List           3.Exit      \n";
print "\t\t\t\t\t\t\t\t4.Modify             5.Search         6.Delete     \n"; 
print "Enter the key\n";
$input=<STDIN>;
chomp($input);
if($input =~ /^[0-9,]*$/) 
  {
 if($input==1)
    {
   name:
   print "Enter the name\n";
   $name=<STDIN>;
   chomp($name);
   $name_error_checking=Validation->NameValidation($name);
    if($name_error_checking eq "false")
      {
       $error1=$PhoneBook::error{'1'};
       print "$error1\n";
       goto name;
      }
    print "Enter the address\n";
    $address=<STDIN>;
    chomp($address);
    father_name:
    print "Enter the Father Name\n";
    $father_Name=<STDIN>;
    chomp($father_Name);
    $name_error_checking=Validation->NameValidation($father_Name);
    if($name_error_checking eq "false")
      {
       $error1=$PhoneBook::error{'1'};
       print "$error1\n";
       goto father_name;
      } 

    mother_name:
    print "Enter the Mother Name\n";
    $mother_Name=<STDIN>;
    chomp($mother_Name);
    $name_error_checking=Validation->NameValidation($mother_Name);
    if($name_error_checking eq "false")
      {
       $error1=$PhoneBook::error{'1'};
       print "$error1\n";
       goto mother_name;
      }
    mobile_number:
    print "Enter Mobile Number\n";
    $mobile_Number=<STDIN>;
    chomp($mobile_Number);
    $mobile_num_error_checking=Validation->MobileValidation($mobile_Number);
    if($mobile_num_error_checking eq "false")
      {
       $error1=$PhoneBook::error{'3'};
       print "$error1\n";
       goto mobile_number;
      }
    Gender:
    print "Enter the Gender\n";
    $gender=<STDIN>;
    chomp($gender);
    $name_error_checking=Validation->NameValidation($gender);
    if($name_error_checking eq "false")
      {
       $error1=$PhoneBook::error{'1'};
       print "$error1\n";
       goto Gender;
      }
    email:
    print "Enter e-mail\n";
    $email=<STDIN>;
    chomp($email);
    $email_error_checking=Validation->EmailValidation($email);
    if($email_error_checking eq "false")
      {
      $error1=$PhoneBook::error{'4'};
      print "$error1\n";
      goto email;
      }
    citizen_number:
    print "Enter the citizen_Number\n";
    $citizen_Number=<STDIN>;
    chomp($citizen_Number);
    my $citizen_num_error_checking=Validation->CitizenNumberValidation($citizen_Number);
    if($citizen_num_error_checking eq "false")
      {
       $error1=$PhoneBook::error{'6'};
       print "$error1\n";
       goto citizen_number;
      }
    my $registration_error_checking=Validation->RegisterData($name,$address,$father_Name,$mother_Name,$mobile_Number,  $gender,$email,$citizen_Number);
    if($registration_error_checking eq "true")
      {
       print "Datas registered Successfully\n";
      }
    else
      {
      print "Datas not registered Successfully\n";
      }
      goto label;
}



if($input==5)
{
    search:
    print "Enter the Name\n";
    $name=<STDIN>;
    chomp($name);
    $name_error_checking=Validation->NameValidation($name);
    if($name_error_checking eq "false") 
      {
      $error1=$PhoneBook::error{'1'};
      print "$error1\n";
      goto search;
      }
      search1:
      print "Enter the Phone_Number\n";
      $mobile_Number=<STDIN>;
      chomp($mobile_Number);
      $mobile_num_error_checking=Validation->MobileValidation($mobile_Number);
    if($mobile_num_error_checking eq "false")
      {
      $error1=$PhoneBook::error{'3'};
      print "$error1\n";
      goto search1;
      }
      $data_error_checking=Validation->DataValidation($name,$mobile_Number);
    if($data_error_checking eq "false")
      {
      $error1=$PhoneBook::error{'2'};
      print "$error1\n";
      }
    if($data_error_checking eq "true")
      {
      print "Data is available\n";
      }
      goto label;
}

if($input==3)
{
     exit;
}

if($input==2)
{
     list:
     print "1.View All Data   2.View Particular Data\n";
     my $input1=<STDIN>;
     chomp($input1);
     if($input1 == 1)
       {
       my $listing_data=Validation::ViewList();
       }

     elsif($input1 ==2)
      {
       number:
       print "Enter the mobile Number\n";
       $mobile_Number=<STDIN>;
       chomp($mobile_Number);
       $mobile_num_error_checking=Validation->MobileValidation($mobile_Number);
      if($mobile_num_error_checking eq "false")
       {
       $error1=$PhoneBook::error{'3'};
       print "$error1\n";
       goto number;
       }
     $listing_data=Validation->ViewParticularDataList($mobile_Number);
     if($listing_data eq "true")
       {
       print "datas are Listed\n";
       goto label;
       }
     if($listing_data eq "false")
       {
       $error1=$PhoneBook::error{'2'};
       print "$error1\n";
       goto label;
       }
     if($listing_data eq "Error")
       {
       $error1=$PhoneBook::error{'5'};
       print "$error1\n";
       goto label;
       }
      }
      else
       {
        print "you have entered the non-listed Entry\n"; 
        goto list;
       } 
      goto label;
}






if($input==4)
{
     update:
     $count=0;
     print "1.Name 2.Address 3.Father_Name 4.Mother_Name \n5.Mobile_Number 6.Gender 7.Email 8.Citizen_Number\n";
     print"choose which you want to update\n";
     $update=<STDIN>;
     chomp($update);
     mobilenumber:
     print "Enter the mobile Number\n";
     $mobile_Number=<STDIN>;
     chomp($mobile_Number);
     $mobile_num_error_checking=Validation->MobileValidation($mobile_Number);
     if($mobile_num_error_checking eq "false")
       {
        $error1=$PhoneBook::error{'3'};
        print "$error1\n";
        goto mobilenumber;
       }
     if($update==1)
       {
       updatename:
       print "Enter the name to be updated\n";
       $name=<STDIN>;
       chomp($name);
       $name_error_checking=Validation->NameValidation($name);
      if($name_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'1'};
         print "$error1\n";
         goto updatename;
        }
        $update_data_error_checking=Validation->UpdateName($name,$mobile_Number);
        print "$update_data_error_checking\n";
      if($update_data_error_checking eq "true")
        {
         $error1=$PhoneBook::error{'7'};
         print "$error1\n";
        }
      if($update_data_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'2'};
         print "$error1\n";
        }
      if($update_data_error_checking eq "Error")
        {
         $error1=$PhoneBook::error{'5'};
         print "$error1\n";
        }
         goto label;
    }

    if($update==2)
       {
       print "Enter the address to be updated\n";
       $address=<STDIN>;
       chomp($address);
       $update_data_error_checking=Validation->UpdateAddress($address,$mobile_Number);
      if($update_data_error_checking eq "true")
        {
         $error1=$PhoneBook::error{'7'};
         print "$error1\n";
         goto label;
        }
      if($update_data_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'2'};
         print "$error1\n";
        }
      if($update_data_error_checking eq "Error")
        {
         $error1=$PhoneBook::error{'5'};
         print "$error1\n";
        }
      goto label;
   }

   if($update==3)
       {
       updatefathername:
       print "Enter Father_Name to be updated\n";
       $father_Name=<STDIN>;
       chomp($father_Name);
       $name_error_checking=Validation->NameValidation($father_Name);
       if($name_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'1'};
          print "$error1\n";
          goto updatefathername;
         }
       $update_data_error_checking=Validation->UpdateFatherName($father_Name,$mobile_Number);
       if($update_data_error_checking eq "true")
         {
          $error1=$PhoneBook::error{'7'};
          print "$error1\n";
          goto label;
         }
       if($update_data_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'2'};
          print "$error1\n";
         }
       if($update_data_error_checking eq "Error")
         {
          $error1=$PhoneBook::error{'5'};
          print "$error1\n";
         }
        goto label;
   }

   if($update==4)
       {
       updatemotherName:
       print "Enter the Mother_Name to be updated\n";
       $mother_Name=<STDIN>;
       chomp($mother_Name);
       $name_error_checking=Validation->NameValidation($mother_Name);
       if($name_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'1'};
          print "$error1\n";
          goto updatemothername;
         }
       $update_data_error_checking=Validation->UpdateMotherName($mother_Name,$mobile_Number);
       if($update_data_error_checking eq "true")
         {
          $error1=$PhoneBook::error{'7'};
          print "$error1\n";
          goto label;
         }
       if($update_data_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'2'};
          print "$error1\n";
         }
       if($update_data_error_checking eq "Error")
         {
          $error1=$PhoneBook::error{'5'};
          print "$error1\n";
         }
        goto label;
   }

   if($update==6)
    {
    updategender:
    print "Enter Gender to be updated\n";
    $gender=<STDIN>;
    chomp($gender);
    $name_error_checking=Validation->NameValidation($name);
      if($name_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'1'};
         print "$error1\n";
         goto updategender;
        }
      $update_data_error_checking=Validation->UpdateGender($gender,$mobile_Number);
      if($update_data_error_checking eq "true")
        {
         $error1=$PhoneBook::error{'7'};
         print "$error1\n";
         goto label;
        }
      if($update_data_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'2'};
         print "$error1\n";
        }
      if($update_data_error_checking eq "Error")
        {
        $error1=$PhoneBook::error{'5'};
        print "$error1\n";
        } 
        goto label;
     }

   if($update==5)
     {
       updatemobilenumber:
       print "Enter name\n";
       $name=<STDIN>;
       chomp($name);
       $name_error_checking=Validation->NameValidation($name);
       if($name_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'1'};
          print "$error1\n";
          goto updatemobileumber;
         }
        $update_data_error_checking=Validation->UpdateMobileNumber($name,$mobile_Number);
        if($update_data_error_checking eq "true")
          {
           $error1=$PhoneBook::error{'7'};
           print "$error1\n";
           goto label;
          }
       if($update_data_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'2'};
          print "$error1\n";
         }

       if($update_data_error_checking eq "Error")
         {
          $error1=$PhoneBook::error{'5'};
          print "$error1\n";
         }
      goto label;
     }

   if($update==7)
     {
       updateemail:
        print "Enter the email to be updated\n";
        $email=<STDIN>;
        chomp($email);
        $email_error_checking=Validation->EmailValidation($email);
        if($email_error_checking eq "false")
          {
           $error1=$PhoneBook::error{'4'};
           print "$error1\n";
           goto updateemail;
          }
        $update_data_error_checking=Validation->UpdateEmail($email,$mobile_Number);
        if($update_data_error_checking eq "true")
          {
           $error1=$PhoneBook::error{'7'};
           print "$error1\n";
           goto label;
          }
       if($update_data_error_checking eq "false")
         {
          $error1=$PhoneBook::error{'2'};
          print "$error1\n";
         }
       if($update_data_error_checking eq "Error")
         {
          $error1=$PhoneBook::error{'5'};
          print "$error1\n";
         }
        goto label;
     }

   if($update==8)
     {
      updatecitizenNumber:
      print "Enter the citizen_Number\n";
      $citizen_Number=<STDIN>; 
      chomp($citizen_Number);
      my $citizen_num_error_checking=Validation->CitizenNumberValidation($citizen_Number);
      if($citizen_num_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'6'};
         print "$error1\n";
         goto updatecitizenNumber;
        }
      $update_data_error_checking=Validation->UpdateCitizenNumber($citizen_Number,$mobile_Number);
      if($update_data_error_checking eq "true")
        {
         $error1=$PhoneBook::error{'7'};
         print "$error1\n";
         goto label;
        }
      if($update_data_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'2'};
         print "$error1\n";
        }
      if($update_data_error_checking eq "Error")
        {
         $error1=$PhoneBook::error{'5'};
         print "$error1\n";
        }
     goto label;
    }

   else
    {
     print "you have Entered Non listed Entry\n";
     goto update;
    }
}


   if($input==6)
     {
      remove:
      print "Enter the mobile Number\n";
      $mobile_Number=<STDIN>;
      chomp($mobile_Number);
      $mobile_num_error_checking=Validation->MobileValidation($mobile_Number);
      if($mobile_num_error_checking eq "false")
        {
         $error1=$PhoneBook::error{'3'};  
         print "$error1\n";
         goto remove;
        }
     $delete_row=Validation->RemoveData($mobile_Number);
      if($delete_row eq "true")
        {
         print "data deleted\n";
         goto label;
        } 
      if($delete_row eq "false")
        {
         $error1=$PhoneBook::error{'2'};
         print "$error1\n";
        }
     if($delete_row eq "Error")
       {
        $error1=$PhoneBook::error{'5'};
        print "$error1\n";
       }
    goto label;
   }
  else
     {
      print "You have Entered non Listed Entry\n";
      goto label;
     }
}
else 
{
    print "Enter the numeric number\n";
    goto label;
 }
1;
