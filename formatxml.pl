#!/usr/bin/env perl
# SPDX-License-Identifier: Apache-2.0

use strict;
use warnings;
use POSIX;

my $indent_size = 2;
my $indent_char = ' ';
my $max_line_length = 100;

sub trim {
	my $s = shift;

	$s =~ s/^\s+|\s+$//g;
	return $s;
}

# Expects two parameters: string to analyze and stack's depth.
sub pretty_print {
	my $s = trim(shift(@_));
	my $total_indent_size = $indent_size * shift(@_);

	if (length($s) <= $max_line_length) {
		print($indent_char x ($total_indent_size));
		print("$s\n");
		return;
	}

	# Compared to /\s+/, ' ' also removes any leading whitespace.
	my @attrs = split(' ', $s);

	$s = $indent_char x ($total_indent_size);
	# Append '<NodeName' and update size.
	$s .= shift(@attrs);
	$total_indent_size = length($s);

	for my $a (@attrs) {
		if (length($s) + length($a) >= $max_line_length) {
			print("$s\n");
			$s = $indent_char x ($total_indent_size);
		}

		$s .= " $a";
	}

	if (length($s) > $total_indent_size) {
		print("$s\n");
	}
}

my ($infilename, $outfilename) = @ARGV;
my ($INFILE, $OUTFILE);

die "Input filename missing\n" if (!$infilename);

open($INFILE, '<', $infilename) || die $!;
if ($outfilename) {
	open($OUTFILE, '>', ".$outfilename.tmp") || die $!;
	select($OUTFILE);
}

my $current_node = "";
my $depth = 0;

while (<$INFILE>) {
	my $line = trim($_);

	next if !length($line);

	if ($line =~ /^<\//) {
		$depth--;
		die "Unbalanded node at line $.:\n$line\n" if ($depth < 0);

		pretty_print($line, $depth);
		next;
	}

	$current_node = join(' ', $current_node, $line);
	# If current node ends here, print it.
	if ($current_node =~ />$/) {
		pretty_print($current_node, $depth);

		# Push stack only when '>' is on its own.
		# TODO: mixed '<node> <!-- comment -->' not supported.
		if ($current_node !~ /[-|\/|\?]>$/) {
			$depth++;
		}
		$current_node = "";
	}
}
close($INFILE);

if ($outfilename) {
	select(STDOUT);
	close($OUTFILE);
}

rename(".$outfilename.tmp", $outfilename) || die $!;
