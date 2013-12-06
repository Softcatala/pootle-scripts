#!/usr/bin/perl -w
use strict; 
use warnings;
use File::Find;

find({ wanted => \&process_file, no_chdir => 1 }, @ARGV);


sub process_file {

if (-f $_) {

        my %hash;
        my $file = $_;

        print "* $file\n";

        open (FILE, $file) || die "cannot open $file";
        while (<FILE>)  {

                if ($_=~/^\#\:\s*(\S.*)\s*/) {
                        $hash{$1}++;
        
                }

        }

        foreach my $key (keys %hash) {


                if ($hash{$key} > 1) {
        
                        print $key, "\n";
                }

        }

        }

}
