#!/usr/local/bin/perl
#
#/********************************************************************************************
#* This code will go through the NCBI gene2pubmed.txt file and create a new file where       *
#* each line contains a publication ID with all the gene IDs described in this publication.  *
#********************************************************************************************/
my (@bufH, %pubH, $tempH, @buf, %pub, $temp, $nb1, $nb2);
open(INPUTH, "<../gene2pubmed-homo.txt");			# will only use the human genes
open(OUTPUTH, ">../pubidsgeneids-homo.txt");
open(OUTPUTH2, ">../nbpubsingene2pubmed-homo.txt");
open(INPUT, "<../resources/gene2pubmed");				# will use all species genes
open(OUTPUT, ">../pubidsgeneids.txt");
open(OUTPUT2, ">../nbpubsingene2pubmed.txt");

$nb1 = $nb2 = 0;
while (<INPUTH>) {
	if (/\t/) {
		@bufH = split(/\t/);
		$bufH[1] =~ s/\n//g;
		$bufH[2] =~ s/\n//g;
		if (@bufH>2) {
			$pubH{$bufH[2]}{$bufH[1]} = 1;
		}
    }
}
foreach my $keyH (keys %pubH) {
    $tempH = 0;
    my $howManyH = keys %{$pubH{$keyH}};
#    print("$howManyH\n");    
    if ($howManyH<=500) {     # limit the number of publications per gene ID
        print(OUTPUTH "$keyH\t");
        foreach my $key2H (keys %{$pubH{$keyH}}) {
            if ($tempH!=0) {
                print(OUTPUTH ",");
            }
            print(OUTPUTH "$key2H");
            $tempH++;
        }
        print(OUTPUTH "\n");
    }
	$nb2++ if ($keyH =~ /^\d+/);
}
print(OUTPUTH2 "$nb2");

while (<INPUT>) {
	if (/\t/) {
		@buf = split(/\t/);
		$buf[1] =~ s/\n//g;
		$buf[2] =~ s/\n//g;
		if (@buf>2) {
			$pub{$buf[2]}{$buf[1]} = 1;
		}
    }
}
foreach my $key (keys %pub) {
    $temp = 0;
    my $howMany = keys %{$pub{$key}};
#    print("$howMany\n");    
    if ($howMany<=500) {     # limit the number of publications per gene ID
        print(OUTPUT "$key\t");
        foreach my $key2 (keys %{$pub{$key}}) {
            if ($temp!=0) {
                print(OUTPUT ",");
            }
            print(OUTPUT "$key2");
            $temp++;
        }
        print(OUTPUT "\n");
    }
	$nb1++ if ($key =~ /^\d+/);
}
print(OUTPUT2 "$nb1");

close(INPUTH);
close(OUTPUTH);
close(OUTPUTH2);
close(INPUT);
close(OUTPUT);
close(OUTPUT2);
