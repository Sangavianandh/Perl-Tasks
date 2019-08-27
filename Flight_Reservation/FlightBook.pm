package FlightBook;
use RegisterValidation;
use strict;
use warnings;
our %error=('1'=>'Error in DataBase Conection! please recheck the Database Connection',  
'2'=>'Please Enter the correct Choice',
'3'=>'ohh!! Please enter the numerical number',
'4'=>'Please Enter the valid name' ,
'5' =>'Please Enter the valid and Existance Email',
'6'=>'Please Enter the valid mobile number',
'7'=>'No data in the database',
'8'=>'Entered mobile number already exist',
'9'=>'February cannot be of more than 28 or 29 days',
'10'=>'Its not a leap year, so please type the date between 1 and 28',
'11'=>'This month only allow upto 30 as th date input',
'12'=>'The provided date is the future date i guess. its year should be less or equal to current Year',
'13'=>'You have entered wrong format of data',
'14'=>'given date does not follow the pattern DD/MM/YYYY or DD-MM-YYYY  or \n you have entered some unvalid date like\n 1.32 as date or \n 2. 13 as month or\n 3. 3100 as year',
'15'=>'The provided date is the future date i guess.',
'16'=>'Please Enter the Alphabet',
'17'=>'You have booked already',
'18'=>'wow!! You had successfully Booked the Ticket',
'19'=>'No such choices are available! please enter the available choice',
'20'=>'Registration Failed',
'21'=>'your Ticket cancelled Successfully',
'22'=>'your booking status is Nill',
'23'=>'Please enter the valid gender name',
'24'=>'your Ticket Rescheduled successfully',
'25'=>'Error in query statement',
'26'=>'you have entered the Invalid Flight_ID',
'27'=>'Flights are not available for',
'28'=>'please enter the correct login_Id',
'29'=>'please do the registeration',
'30'=>'Please Enter the proper location name',
'31'=>'Booking over');
sub new{
my $class;
$class=shift;
our $self={};
$self->{dbh}=RegisterValidation::Connection();	
$self->{register}=$self->{dbh}->prepare(q{ SELECT Id FROM Register where Mobile_Number=? and Name=?});
$self->{register1}=$self->{dbh}->prepare(q{ SELECT * FROM Register where Id=? and Mobile_Number=? and Name=?});
$self->{login}=$self->{dbh}->prepare(q{select Id from Register where Mobile_Number=?});
$self->{insert}=$self->{dbh}->prepare(q{INSERT INTO Register(Name,Email,Mobile_Number) values(?,?,?)});
$self->{Display_id}=$self->{dbh}->prepare(q{select Id from Register where Mobile_Number=?});
$self->{Flight_Avai}=$self->{dbh}->prepare(q{select Flight_ID,Flight_Name,Travel_Place_ID,Seat_Availability,Satrting_Time,Destination_Time,ID from Flight_Details where Travel_Date and Travel_Place_ID in (select Travel_Place_ID from Travel_Place_Info where Boarding_From =?and Landing_To=?and Travel_Date=?)});
$self->{Flight_Avai_Table}=$self->{dbh}->prepare(q{CREATE TABLE Flight_Availability (
                         Id int not null,
                         Flight_ID varchar(5) NOT NULL,
	                 Flight_Name varchar(25) NOT NULL,
	                 Travel_Place_ID Int not null,
                         Seat_Availability int not null,
                         Arraival_Time varchar(5) not null,
                         Departure_Time varchar(5) not null,
                         foreign key(Id) REFERENCES Flight_Details(ID)
                         )});
$self->{Insert_Flight_Availability}=$self->{dbh}->prepare(q{Insert into Flight_Availability  (Id,Flight_ID,Flight_Name,Travel_Place_ID,Seat_Availability,Arraival_Time,Departure_Time)values(?,?,?,?,?,?,?)});
$self->{select_Flight_Availability}=$self->{dbh}->prepare(q{select * from Flight_Availability where Flight_ID=?}); 
$self->{check_ID_from_Flight_Availability}=$self->{dbh}->prepare(q{select Id,Seat_Availability,Flight_Name,Arraival_Time,Departure_Time from Flight_Availability where Flight_ID=?});
$self->{Booking_Status}=$self->{dbh}->prepare(q{select First_Name from Passenger_Details where Flight_ID=? and Flight_Name=? and First_Name=? and Travel_Date=? and Mobile_Number=?});
$self->{Insert_Passenger_Details}=$self->{dbh}->prepare(q{Insert into Passenger_Details   (Login_ID,Flight_ID,Flight_Name,Travel_Date,Starting_Place,Destination_Place,Arraival_Time,Departure_Time,First_Name,Last_Name,Age,Gender,Mobile_Number,Email,ID) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,null)});
$self->{Passenger_Details_from_Id}=$self->{dbh}->prepare(q{select * from Passenger_Details where Login_ID=?});
$self->{from_Passenger_Details}=$self->{dbh}->prepare(q{select Flight_ID,Flight_Name,Travel_Date,Starting_Place,Destination_Place,Arraival_Time,Departure_Time from Passenger_Details where ID=?});
$self->{Ticket_Cancel}=$self->{dbh}->prepare(q{Delete from Passenger_Details where ID=?});
$self->{IDandSeatfrom_Passenger_Details}=$self->{dbh}->prepare(q{select ID, Seat_Availability from Flight_Details where Flight_ID=? and Flight_Name=? and Travel_Date=? and Satrting_Time=? and Destination_Time=? and Travel_Place_ID in (select Travel_Place_ID from Travel_Place_Info where Boarding_From =? and Landing_To=?)});
$self->{select_All_ID}=$self->{dbh}->prepare(q{select * from Passenger_Details where Login_ID=?});
$self->{select_Particular_ID}=$self->{dbh}->prepare(q{select Flight_ID,Flight_Name,Travel_Date,Starting_Place,Destination_Place,Arraival_Time,Departure_Time,First_Name,Last_Name,Mobile_Number from Passenger_Details where ID=?});
$self->{select_Details_ID}=$self->{dbh}->prepare(q{select ID, Seat_Availability from Flight_Details where Flight_ID=? and Flight_Name=? and Travel_Date=? and Satrting_Time=? and Destination_Time=? and Travel_Place_ID in (select Travel_Place_ID from Travel_Place_Info where Boarding_From =? and Landing_To=?)}); 
$self->{Cancel_Ticket}=$self->{dbh}->prepare(q{Delete from Passenger_Details where ID=?});
$self->{Reschedule}=$self->{dbh}->prepare(q{select Flight_ID,Flight_Name,Travel_Date,Starting_Place,Destination_Place,Arraival_Time,Departure_Time,First_Name,Last_Name,Mobile_Number from Passenger_Details where ID=?});
$self->{Reschedule1}=$self->{dbh}->prepare(q{select ID, Seat_Availability from Flight_Details where Flight_ID=? and Flight_Name=? and Travel_Date=? and Satrting_Time=? and Destination_Time=? and Travel_Place_ID in (select Travel_Place_ID from Travel_Place_Info where Boarding_From =? and Landing_To=?)});
$self->{Reschedule2}=$self->{dbh}->prepare(q{select Id,Seat_Availability,Flight_Name,Arraival_Time,Departure_Time from Flight_Availability where Flight_ID=?});
$self->{Reschedule3}=$self->{dbh}->prepare(q{select * from Passenger_Details where Travel_Date=? and Starting_Place=? and Destination_Place=? and First_Name=? and Last_Name=? and Mobile_Number=?});
}
1;

