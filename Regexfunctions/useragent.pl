use strict;
use warnings;
use LWP::UserAgent; 
my($ua,$response,$content,$filename,$product_Name,$product_Price,$i);
$ua = LWP::UserAgent->new();
$ua->agent('Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0');
$response = $ua->get('https://store.berniesanders.com/collections/apparel/products/feel-the-bern-tank-top');
$content = $response->content;
$filename = 'useragent14.pl';
if(! -e $filename){
open(DATA, '>>', $filename) or die "Could not open file '$filename' $!"; 
print DATA $content;
close DATA;
}

print "Product Name:\n";
  if($content =~ /\s*(<h1)(.*">)(.*)(.*<\/h1>$)/gm) 
    { 
     $product_Name=$3;
     print "\t\t$3\n";
    }
    print "Product price:\n";
 if($content =~ /(\$.+\d)/)
   {
    $product_Price=$1;
    print "\t\t$1\n";
   }         
 while($content =~ /(<opt.*">)(.*[3XL2LGMD])(\s.*)/gm)
     {
       print "\t\t$2\n";
     }
   print "Image URL:\n";
 if($content =~ /(.*image.*=")(https.*\d)/)
   {
    print "\t\t$2\n";
   }

