use strict;
use feature 'say';

my $file_name = 'test_input';
my $test_count = 9999999;
my $valgrind = 'valgrind -v --show-leak-kinds=all --track-origins=yes --leak-check=full ';
my @expected;
my $key_limit = 99999;
my $rand;
my $command_string;
my @rem_while;
my %command = (
	'al' => \&pu,
	'af' => \&un,
	'rl' => \&po,
	'rf' => \&sh,
);
my @com = keys %command;

open my $fh, '>', $file_name
or die "Could not open $file_name, $!";

for(1 .. $test_count) {
	$\ = "\n";
	$rand = int(rand($key_limit));
	$command_string = $com[ int rand @com ];
	$_ = &{$command{ $command_string }}(\@expected, $rand);
	push (@rem_while, $_) if ($command_string eq 'rl' || $command_string eq 'rf');
	print {$fh} "$command_string $rand";
} 
close $fh;

@_ = split /\s+/, qx(./test $test_count $file_name);

#@rem_while = grep { defined $_ } @rem_while;
#@_ = grep { defined $_ } @_;
my $err = undef;
for (0 .. scalar @_) {
	if ($_[$_] != $rem_while[$_]) {
		say "Ups $_[$_] != $rem_while[$_]";
		$err++;
	}
}
say "Errors: $err" if defined $err;
say "Alright!" if !defined $err;

sub pu {
	push @{$_[0]}, $_[1];
	return undef;
}
sub sh {
	return shift @{$_[0]};
}
sub po {
	return pop @{$_[0]};
}
sub un {
	unshift @{$_[0]}, $_[1];
	return undef;
}
