use strict;
use warnings;
use LWP::UserAgent; 
my($ua,$response,$content,$filename,$product_Name,$product_Price,$i);
$ua = LWP::UserAgent->new();
$ua->agent('Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0');
$response = $ua->get('https://www.beallsflorida.com/online/tropix-splash-sea-turtle-dinner-plate');
$content = $response->content;
$filename = 'useragent14.pl';
if(! -e $filename){
open(DATA, '>>', $filename) or die "Could not open file '$filename' $!"; 
print DATA $content;
close DATA;
}
print"\n";
my ($Product_Name,$price,$size,$color,%hash);
if($content =~ /<title>(.*?)\|*?<\/title>/)
{
$Product_Name=$1;
print "product_Name=\t\t$Product_Name\n";
}
if($content =~/offerPrice.*?(\$.*?)\s<\/span>/s)
{
$price=$1;
print "Product_price=\t\t$price";
}
if($content =~/og:image".*?"(.*?)"/)
{
my $image_url=$1;
print "Product_image_url=\t$image_url\n";
}
print "===================================================================\n";
print "Availability\t\tsize\t\t        Color\n";
print "===================================================================\n";
while($content=~ /buyable"\s:\s"(.*?)",\s+"Attributes"\s:\s{(\s+)"Color_\|_(.*?)":"(.*?)"\s+,\s+"Size_\|_(.*?)":/sg)
{
$size=$5;
$color=$3;
if($1 eq "true")
{
print "Available\t\t$size\t\t$color\n";
}
else
{
print "Not Available\t\t$size\t\t$color\n";
}
}
while($content=~ /buyable"\s:\s"(.*?)",\s+"Attributes"\s:\s{(\s+)"Size_\|_(.*?)":"(.*?)"\s+,\s+"Color_\|_(.*?)":/sg)
{
$size=$3;
$color=$5;

if($1 eq "true")
{
print "Available\t\t$size\t\t$color\n";
}
else
{
print "Not Available\t\t$size\t\t$color\n";
}


}



