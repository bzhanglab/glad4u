#!/usr/bin/perl
#   written by Jerome Jourquin - July 2009
		##############
		# install.pl #
		##############

# this script is a wrapper script, see other script files for more details.

print "\n\tGLAD4U will be installed in 6 steps [the process will take few minutes]...\n\n";

print "\t\tSTEP 1 [script 'gene2pubmed.pl', text files 'gene2pubmed-homo.txt', 'nbgenesingene2pubmed.txt' and 'nbgenesingene2pubmed-homo.txt']...";
do "gene2pubmed.pl";
print "COMPLETED.\n";

print "\t\tSTEP 2 [script 'geneidspubids.pl', text files 'geneidspubids.txt' and 'geneidspubids-homo.txt']...";
do "geneidspubids.pl";
print "COMPLETED.\n";

print "\t\tSTEP 3 [script 'pubidsgeneids.pl', text files 'pubidsgeneids.txt', 'pubidsgeneids-homo.txt', 'nbpubsingene2pubmed.txt' and 'nbpubsingene2pubmed-homo.txt']...";
do "pubidsgeneids.pl";
print "COMPLETED.\n";

print "\t\tSTEP 4 [script 'geneidsnbpubids.pl', text files 'geneidsnbpubids.txt' and 'geneidsnbpubids-homo.txt']...";
do "geneidsnbpubids.pl";
print "COMPLETED.\n";

print "\t\tSTEP 5 [script 'pubidsnbgeneids.pl', text files 'pubidsnbgeneids.txt' and 'pubidsnbgeneids-homo.txt']...";
do "pubidsnbgeneids.pl";
print "COMPLETED.\n";

#	print "\t\tSTEP 6 [script 'geneidsmimids.pl', text file 'geneidsmimids.txt']...";
#	do "geneidsmimids.pl";
#	print "COMPLETED.\n";
	
#	print "\t\tSTEP 7 [script 'mimidsgeneids.pl', text file 'mimidsgeneids.txt']...";
#	do "mimidsgeneids.pl";
#	print "COMPLETED.\n";
	
#	print "\t\tSTEP 8 [script 'geneidsnbmimids.pl', text file 'geneidsnbmimids.txt']...";
#	do "geneidsnbmimids.pl";
#	print "COMPLETED.\n";
	
#	print "\t\tSTEP 9 [script 'mimidsnbgeneids.pl', text file 'mimidsnbgeneids.txt']...";
#	do "mimidsnbgeneids.pl";
#	print "COMPLETED.\n";

print "\t\tSTEP 6 [script 'geneidsgenenames.pl', text files 'geneidsgenenames.txt', 'genenamesgeneids.txt', 'geneidsgenenames-homo.txt' and 'genenamesgeneids-homo.txt']...";
do "geneidsgenenames.pl";
print "COMPLETED.\n\n";

print "\tAll scripts have been COMPLETED.\n\t\tAll scripts and files are in the folder 'core_files'.\n\t\tDO NOT delete any of these files or GLAD4U will not work.\n\t\tRerun 'install.pl' if necessary.\n\n";