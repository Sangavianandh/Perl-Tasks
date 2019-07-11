#this program explains thwe simple way of checking any scalar variable in array
#and this is used for smartmatch    
use v5.10.1;
        @array = (1, 2,undef,6, 4, 5);
        say "array" if (undef,1,2) ~~ @array;
