use Data::Dumper qw(Dumper);
my %family_members;
my $index1;
my $key;
my $name;
my $value;
my $age;
my(@val,@ke,$salary);
format FAMILY=
===================================
@<<<<<<<<<<<<<<<<<<<@<
$name    $age
@#####.##
$salary
===================================
.

format FAMILY_TOP =
===================================
Name                    Age
===================================
.
select(STDOUT);
$~ = FAMILY;
$^ =FAMILY_TOP;
print "Enter the count\n";
my $n=<STDIN>;
for($index1=0;$index1<$n;$index1++)
{
$key=<STDIN>;
chomp($key);
$value=<STDIN>;
chomp($value);
$salary=<STDIN>;
chomp($salary);
$family_members{$key}{$value}=$salary;
}
@key=keys %family_members;
print Dumper \%family_members;
foreach  $name(keys %family_members)
{
foreach  $age(keys %{$family_members{$name}})
{
write;
}
}


