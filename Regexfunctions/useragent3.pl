use strict;
use warnings;
use LWP::UserAgent; 
my($ua,$response,$content,$filename,$product_Name,$product_Price,$i);
$ua = LWP::UserAgent->new();
$ua->agent('Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0');
$response = $ua->get('https://direct.asda.com/george/kids/girls-underwear-socks-tights/girls-black-super-soft-school-tights-5-pack/GEM703981,default,pd.html?cgid=D25M2G1C9');
$content = $response->content;
$filename = 'useragent22.pl';
if(! -e $filename)
{
open(DATA, '>>', $filename) or die "Could not open file '$filename' $!"; 
print DATA $content;
close DATA;
}
if($content =~ /(id"..)(.*?\d)(".*?name...)(.*?)(".)/)
{
print "product_Id=$2\t\t\nproduct_Name=$4\n";
}
print "\nImage URL:";
if($content =~/(images.*?\d")(.*?:")(.*?\?)/)
{
print "$3\n";
}
print "============================================\n";
print "Availability\t\tprice\t\tsize\n";
print "============================================\n";
while($content =~ /(name..")(.*?)(".*?:")(.*?\d)(".*?":)(false|true)(.*?images.*?\d")(.*?:")(.*?\?)(.*?")(\£\d.*?\d)(".*?size":).*?displayValue\"\:\"(.*?)\"([^>]*?)>/mg)
{
if($6 eq "false" )
{
print "not Available\t\t$11\t\t$13\n";
}
else
{
print "Available\t\t$11\t\t$13\n";
}
}

#\"displayValue\"\:\"(.*?)\".*?\"selectable\"(.*?)\}
#\"attributeId\"\:\"size"([^>]*?)<
