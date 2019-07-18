package PhoneBook;
use Validation;
use strict;
use warnings;
our %error=('1'=>'Entered name is not valid',  
'2'=>'No such data in the database',
'3'=>'Mobile Number is not valid',
'4'=>'Email id is not valid' ,
'5' =>'Error in DataBaseConection',
'6'=>'invalid citizen number',
'7'=>'Data updated Successfully');
sub new{
my $class;
$class=shift;
our $self={};
$self->{dbh}=Validation::Connection();
$self->{insert}=$self->{dbh}->prepare("INSERT INTO Register(name_,address,father_Name,mother_Name,mobile_number,gender,email,citizen_Number)values
                       (?,?,?,?,?,?,?,?)");
$self->{viewall}=$self->{dbh}->prepare("SELECT * FROM Register");
$self->{mobilenum}=$self->{dbh}->prepare("SELECT * FROM Register where Mobile_number=?");
$self->{remove}=$self->{dbh}->prepare("DELETE FROM Register where mobile_number=?");
$self->{search}=$self->{dbh}->prepare("SELECT * FROM Register where name_=? and mobile_number=?");
$self->{updcitizennumber}=$self->{dbh}->prepare("update Register set citizen_Number=? where mobile_number=?");
$self->{updname}=$self->{dbh}->prepare("update Register set name_=? where mobile_number=?");
$self->{updaddress}=$self->{dbh}->prepare("update Register set address=? where mobile_number=?");
$self->{updfathername}=$self->{dbh}->prepare("update Register set father_Name=? where mobile_number=?");
$self->{updmothername}=$self->{dbh}->prepare("update Register set mother_Name=? where mobile_number=?");
$self->{updemail}=$self->{dbh}->prepare("update Register set email=? where mobile_number=?");
$self->{updgender}=$self->{dbh}->prepare("update Register set gender=? where mobile_number=?");
return bless $self, $class;
}



