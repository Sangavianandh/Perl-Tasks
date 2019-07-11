#!/usr/bin/perl
package Register;
use strict;
use warnings;
sub new 
   my $class = shift;
   my $self = {
      name => shift,
      address=> shift,
      father_Name  => shift,
      mother_Name  => shift,
      phone_Number => shift,
      email        =>shift,    
      gender        => shift,
      citizen_Number=>shift
   };
   # Print all the values just for clarification.
   print "Name is $self->{name}\n";
   print "Address is $self->{_address}\n";
   print "Father_name is $self->{_father_name}\n";
   bless $self, $class;
   return $self;
}
sub setName {
   my ( $self, $_name ) = @_;
   $self->{name} = $_name if defined($_name);
}

sub getName {
   my( $self ) = @_;
   return $self->{name};
}
sub setAddress{
   my ( $self, $_address ) = @_;
   $self->{address} = $_address if defined($_address);
}

sub getAddress {
   my( $self ) = @_;
   return $self->{address};
}
sub setFatherName {
   my ( $self, $_fatherName ) = @_;
   $self->{father_Name} = $_fatherName if defined($_fatherName);
}

sub getFatherName {
   my( $self ) = @_;
   return $self->{father_Name};
}

sub setMotherName {
   my ( $self, $_motherName ) = @_;
   $self->{mother_Name} = $_motherName if defined($_motherName);
}
sub getMotherName {
   my( $self ) = @_;
   return $self->{mother_Name};
}

sub setPhoneNumber {
   my ( $self, $_phoneNumber ) = @_;
   $self->{phone_Number} = $_phoneNumber if defined($_phoneNumber);
}

sub getPhoneNumber {
   my( $self ) = @_;
   return $self->{phone_Number};
}

sub setGender {
   my ( $self, $_gender ) = @_;
   $self->{gender} = $_gender if defined($_gender);
}

sub getGender {
   my( $self ) = @_;
   return $self->{gender};
}

sub setEmail {
   my ( $self, $_email ) = @_;
   $self->{email} = $_email if defined($_email);
}

sub getEmail {
   my( $self ) = @_;
   return $self->{email};
}

sub setCitizenNumber {
   my ( $self, $_citizen_Number ) = @_;
   $self->{citizen_Number} = $_citizen_Number if defined($_citizen_Number);
}

sub getCitizenNumber {
   my( $self ) = @_;
   return $self->{citizen_Number};
}
1;
