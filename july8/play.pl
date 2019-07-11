#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use XML::LibXML;
my $xml_string;
my $filename = 'playlist.xml';

my $dom = XML::LibXML->load_xml(location => $filename);

foreach my $title ($dom->findnodes('//booked_person')) {
    say 'title-',$title->findvalue('./person/@name');
$xml_string=
}
