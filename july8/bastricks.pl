#!/usr/bin/perl

@files = `ls -l`;

foreach $file (@files) {
   print $file;
}

1;
