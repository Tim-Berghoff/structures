#!/bin/perl -w

use strict;
use warnings;
use feature 'say';

# TEST VARIABLES
my $program = "./test ";
my $file = "test_input";
my $node_limit = 199999;
my $key_limit = 10000;
my $err = 0;

# prepare arguments
open my $out, ">", $file or die "Couldn't open '$file' for writing $!";
for (1 .. $node_limit) {
	print {$out} int(rand($key_limit))."\n";     # more or less random key
#	print "$test[-2] $test[-1] " ;         # debug
	print {$out} "RM\n" unless 0 == $_ || rand() < 0.1; # trying
	print {$out} "CK\n" unless rand() <= 0.1;           # trying
}
print {$out} "CK";

# execute program with prepared arguments and process output 
$_ = qx($program $file) or die "Couldn't exec " . $!;

@_ = split /:/, $_;
# program seems to not have output anything
die "$program gave no output." unless @_;
$err = shift @_;
chomp($err);
print "ERROR COUNT : " .$err . ((1 == $err) ? " error" : " errors") . " found.\n";
say "Tested: " . shift @_;
say "Removeals: " . shift @_;
say "Average size: " . shift @_;

sub read_file {
	my ($filename) = @_;
	open my $in, "<", $filename or die "Couldn't open '$filename' for reading $!";
	local $/ = undef;
	my $string = <$in>;
	close $in;
	return $string;
}
sub write_file {
	my ($filename, $content) = @_;
	open my $out, ">", $filename or die "Couldn't open '$filename' for writing $!";
	print $out $content;
	close $out;
	return;
}
