use strict;
use feature 'say';

my $program;
my $valgrind = " ";
$program = "test " if lc $^O eq "mswin32";
$program = "./test " if lc $^O eq "linux";
$valgrind = 'valgrind -v --show-leak-kinds=all --track-origins=yes --leak-check=full ' if lc $^O eq "linux";
my $file_name = 'test_input';
my $test_count = 1999999;
my $key_limit = 999999;
my %command = (
	'al' => \&pu,
	'af' => \&un,
	'rl' => \&po,
	'rf' => \&sh,
);
my @ckeys = keys %command;
my $c_str;
my @reference;
my @deletes;
my $rand;

open my $fh, '>', $file_name
or die "Could not open $file_name, $!";

for(1 .. $test_count) {
	$\ = "\n";
	$rand = int(rand($key_limit));
	$c_str = $ckeys[ int rand @ckeys ];                     # random command
	$_ = &{$command{ $c_str }}(\@reference, $rand);         # execute random
	push @deletes, "$c_str:$_" if $_ ne 'insert';					# push to deletes
	print {$fh} "$c_str ".(('insert' eq $_) ? " $rand":" ");
} 
close $fh;

@_ = split /\s+/, qx($valgrind $program $test_count $file_name);
my $err = 0;

for ( 0 .. scalar @_ ) {
	$err++ if $_[$_] ne $deletes[$_];
}
say "Errors in list implementaion: $err";

sub pu {
	push @{$_[0]}, $_[1];
	return "insert";
}
sub sh {
	my $ret = shift @{$_[0]};
	return (defined $ret) ? $ret : 'empty';
}
sub po {
	my $ret = pop @{$_[0]};
	return (defined $ret) ? $ret : 'empty';
}
sub un {
	unshift @{$_[0]}, $_[1];
	return "insert";
}
