#!/usr/local/bin/perl
#
#/********************************************************************************
# * This code will create a version of gene2pubmed.txt with only the human genes *
# ********************************************************************************/

my (@buf, %geneh, %gene, $temp, $nb1, $nb2, $nb3, $nb4);
open(INPUT, "<../resources/gene2pubmed");
open(OUTPUT1, ">../gene2pubmed-homo.txt");
open(OUTPUT2, ">../nbgenesingene2pubmed.txt");
open(OUTPUT3, ">../nbgenesingene2pubmed-homo.txt");

$nb1 = $nb2 = $nb3 = $nb4 = 0;
while (<INPUT>) {
	if ((/^9606/) || (/Format/)) {
		print(OUTPUT1 "$_");
		if (/^\d/) {
			$_ =~ /^\d+\t(\d+)\t/;
			$geneh{$1} = 1;
		}
	}
	if (/^\d/) {
		$_ =~ /^\d+\t(\d+)\t/;
		$gene{$1} = 1;
	}
}

for my $key (keys %gene) { $nb1++; }
for my $keyh (keys %geneh) { $nb2++; }

print(OUTPUT2 "$nb1");
print(OUTPUT3 "$nb2");

close(INPUT);
close(OUTPUT1);
close(OUTPUT2);
close(OUTPUT3);
