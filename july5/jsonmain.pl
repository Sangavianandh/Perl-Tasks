
use JSON;
require Employee;
my $JSON = JSON->new->utf8;
$JSON->convert_blessed(1);

$e = new Employee( "sachin", "sports", "5/6/2019");
$json = $JSON->encode($e);
print "$json\n";
1;
