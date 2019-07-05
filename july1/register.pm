package register;

sub new {
   my $class = shift;
   my $self = {
      _email => shift,
      _mobile  => shift,
     
   };
   # Print all the values just for clarification.
   print "email is $self->{_email}\n";
   print "mobile number is $self->{_mobile}\n";
   bless $self, $class;
   return $self;
}
sub setEmail {
   my ( $self, $email ) = @_;
   $self->{_email} = $email if defined($email);
   return $self->{_email};
}

sub getEmail {
   my( $self ) = @_;
   return $self->{_email};
}
sub setMobile{
my ($self,$mobile)=@_;
$self->{_mobile}=$mobile if defined($mobile);
return $self->{_mobile};
}

sub getMobile {
   my( $self ) = @_;
   return $self->{_mobile};
}
1;


