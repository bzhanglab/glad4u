#!/usr/local/bin/perl
#
#/******************************************************************************************
# * This code will go through the NCBI All_Data.gene_info file and create a new file where *
# * each line contains a gene ID with all the MIM IDs describing this gene.	 	           *
# ******************************************************************************************/
my (@buf, %gene, $temp);
open(INPUT, "<../resources/All_Data.gene_info");
open(INPUT2, "<../resources/names.dmp");
open(OUTPUT1, ">../geneidsgenenames.txt");
open(OUTPUT2, ">../genenamesgeneids.txt");
open(OUTPUT3, ">../geneidsgenenames-homo.txt");
open(OUTPUT4, ">../genenamesgeneids-homo.txt");
open(OUTPUT5, ">../taxidstaxnames.txt");

while (<INPUT>) {
	if (/\t/) {
		@buf = split(/\t/);
		$buf[0] =~ s/\n//g;
		$buf[1] =~ s/\n//g;
		$buf[2] =~ s/\n//g;
		if (@buf>3) {
			$gene{$buf[0]}{$buf[1]}{$buf[2]} = 1;
		}
	}
}

while (<INPUT2>) {
	if (/scientific name/) {
		@buf = split(/\t/);
		$buf[0] =~ s/\n//g;
		$buf[2] =~ s/\n//g;
		if (@buf>3) {
#			$taxid{$buf[0]} = $buf[2];
			print OUTPUT5 "$buf[0]\t$buf[2]\n";
		}
	}
}

foreach my $key (keys %gene) {
	foreach my $key2 (keys %{$gene{$key}}) {
		$temp = 0;
			print(OUTPUT1 "$key2\t");
			if ($key=~/9606/) { print(OUTPUT3 "$key2\t"); }
			foreach my $key3 (keys %{$gene{$key}{$key2}}) {
				if ($temp!=0) {
					print(OUTPUT1 ",");
					if ($key=~/9606/) { print(OUTPUT3 ","); }
				}
				print(OUTPUT1 "$key3");
				if ($key=~/9606/) { print(OUTPUT3 "$key3"); }
				print(OUTPUT2 "$key3\t$key2");
				if ($key=~/9606/) { print(OUTPUT4 "$key3\t$key2"); }
				$temp++;
			}
			print(OUTPUT1 "\t$key\n");
			if ($key=~/9606/) { print(OUTPUT3 "\n"); }
			print(OUTPUT2 "\t$key\n");
			if ($key=~/9606/) { print(OUTPUT4 "\n"); }
	}
}

close(INPUT);
close(OUTPUT1);
close(OUTPUT2);
close(OUTPUT3);
close(OUTPUT4);
