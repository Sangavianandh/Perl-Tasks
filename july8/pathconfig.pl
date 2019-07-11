#!/usr/bin/perl
use strict;
use warnings;

use Config::Any;

my @files = (
        'home/adpc-56/PerlRepository/july5/pathconfig.pl',
        'home/adpc-56/PerlRepository/july5/path.pl'
);

my $config = Config::Any->load_files( { files => \@files } );

