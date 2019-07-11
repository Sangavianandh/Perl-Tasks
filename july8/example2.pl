        use v5.10.1;
        my %hash = (red    => 1, blue   => 2, green  => 3,
                    orange => 4, yellow => 5, purple => 6,
                    black  => 7, grey   => 8, white  => 9);
        my @array = qw(red blue green);
        say "some array elements in hash keys" if  @array ~~  %hash;
        say "some array elements in hash keys" if \@array ~~ \%hash;
        say "red in array" if "red" ~~  @array;
        say "red in array" if "red" ~~ \@array;
        say "some keys end in e" if /e$/ ~~  %hash;
        say "some keys end in e" if /e$/ ~~ \%hash;
