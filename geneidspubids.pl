#!/usr/local/bin/perl
#
#/***************************************************************************************
# * This code will go through the NCBI gene2pubmed.txt file and create a new file where *
# * each line contains a gene ID with all the publications IDs describing this gene.    *
# ***************************************************************************************/
my (@bufH, %geneH, $tempH, @buf, %gene, $temp);
open(INPUTH, "<../gene2pubmed-homo.txt");		# will only use the human genes
open(OUTPUTH, ">../geneidspubids-homo.txt");
open(INPUT, "<../resources/gene2pubmed");			# will use all species genes
open(OUTPUT, ">../geneidspubids.txt");

while (<INPUTH>) {
	if (/\t/) {
		@bufH = split(/\t/);
		$bufH[1] =~ s/\n//g;
		$bufH[2] =~ s/\n//g;
		if (@bufH>2) {
			$geneH{$bufH[1]}{$bufH[2]} = 1;
		}
	}
}
foreach my $keyH (keys %geneH) {
    $tempH = 0;
#    my $howManyH = keys %{$geneH{$keyH}};
#    print("$howManyH\n");
#    if ($howManyH <= 10) {     # limit the number of publications per gene ID
        print(OUTPUTH "$keyH\t");
        foreach my $key2H (keys %{$geneH{$keyH}}) {
            if ($tempH!=0) {
                print(OUTPUTH ",");
            }
            print(OUTPUTH "$key2H");
            $tempH++;
        }
        print(OUTPUTH "\n");
#    }
}

while (<INPUT>) {
	if (/\t/) {
		@buf = split(/\t/);
		$buf[1] =~ s/\n//g;
		$buf[2] =~ s/\n//g;
		if (@buf>2) {
			$gene{$buf[1]}{$buf[2]} = 1;
		}
	}
}
foreach my $key (keys %gene) {
    $temp = 0;
#    my $howMany = keys %{$gene{$key}};
#    print("$howMany\n");
#    if ($howMany <= 10) {     # limit the number of publications per gene ID
        print(OUTPUT "$key\t");
        foreach my $key2 (keys %{$gene{$key}}) {
            if ($temp!=0) {
                print(OUTPUT ",");
            }
            print(OUTPUT "$key2");
            $temp++;
        }
        print(OUTPUT "\n");
#    }
}

close(INPUTH);
close(OUTPUTH);
close(INPUT);
close(OUTPUT);
