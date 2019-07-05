require main;
use Data::Dumper;
use strict;
use warnings;
use 5.12.0;
print "Enter the employee count\n";
my $input=<STDIN>;
chomp($input);
my ($index1,$index2,@array,@array1,$object);
for($index1=0;$index1<=$input;$index1++)
{
print "Enter the $index1 Employee details\n";
for($index2=0;$index2<4;$index2++)
{
$array[$index1][$index2]=<STDIN>;
}
$object=new main(@array);
#$array1[$index1]=@array;
#push(@array1,@array);
}
#print Dumper\@array1;
print Dumper \@array; 
1;
