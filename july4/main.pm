package main;
use strict;
use warnings;
my ($self,$class);
sub new{
$class=shift;
$self={name=>shift,
       id=>shift,
       email=>shift,
       mobile=>shift};
print "name=$self->{name}\n";
print "id=$self->{id}";
bless $self,$class;
return $self;
}

sub setName{
my $self = shift;
	if (scalar(@_) == 0)
	{
		$self->{"name"} = @_;
	}
	return $self->{"name"};
}

sub getName{
my($name)=@_;
return $self->{name};
}

sub setId{
my($self,$id)=@_;
$self->{id}=$id if defined($id);
return $self->{id};
}

sub getId{
my($id)=@_;
return $self->{id};
}

sub setEmail{
my($self,$email)=@_;
$self->{email}=$email if defined($email);
return $self->{email};
}

sub getEmail{
my($email)=@_;
return $self->{email};
}

sub setMobile{
my($self,$mobile)=@_;
$self->{mobile}=$mobile if defined($mobile);
return $self->{mobile};
}

sub getMobile{
my($mobile)=@_;
return $self->{mobile};
}

1;
