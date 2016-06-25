<?php

	set_time_limit(0);
	ini_set('display_errors', TRUE);
	
	$normal = file_get_contents('../../index_normal.php');
	$maintenance = file_get_contents('../../index_unavailable.php');
	
	// first step, put the site 'offline'
	$fp = fopen('../../index.php', 'w+') or die('Cannot open index.php. Automatic update cannot be done. Contact the System Administrator');
	fwrite($fp, $maintenance);
	fclose($fp);
	
	// second step, get the files from NCBI FTP Servers
	if (!file_exists('temp')) { mkdir('temp', 0777); }

	checkTime(microtime_float());
	$url = "ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene2pubmed.gz";
	$fp = fopen('temp/gene2pubmed.gz', 'w+');
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_TIMEOUT, 50);
	curl_setopt($ch, CURLOPT_FILE, $fp);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_exec($ch);
	curl_close($ch);
	fclose($fp);
	if (file_exists('temp/gene2pubmed.gz')) {
		exec('gunzip temp/gene2pubmed.gz');														// unzip the downloaded file
		if (file_exists('../resources/gene2pubmed')) { unlink('../resources/gene2pubmed'); }	// delete the current file
		exec('mv temp/gene2pubmed ../resources');												// move the new file
	}

	checkTime(microtime_float());
	$url = "ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdmp.zip";
	$fp = fopen('temp/taxdmp.zip', 'w+');
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_TIMEOUT, 50);
	curl_setopt($ch, CURLOPT_FILE, $fp);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_exec($ch);
	curl_close($ch);
	fclose($fp);	
	if (file_exists('temp/taxdmp.zip')) {
		exec('unzip temp/taxdmp.zip -d temp');												// unzip the downloaded file
		if (file_exists('../resources/names.dmp')) { unlink('../resources/names.dmp'); }	// delete the current file
		exec('mv temp/names.dmp ../resources');												// move the new file
	}

	checkTime(microtime_float());
	$url = "ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/All_Data.gene_info.gz";
	$fp = fopen('temp/All_Data.gene_info.gz', 'w+');
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_TIMEOUT, 120);
	curl_setopt($ch, CURLOPT_FILE, $fp);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_exec($ch);
	curl_close($ch);
	fclose($fp);	
	if (file_exists('temp/All_Data.gene_info.gz')) {
		exec('gunzip temp/All_Data.gene_info.gz');															// unzip the downloaded file
		if (file_exists('../resources/All_Data.gene_info')) { unlink('../resources/All_Data.gene_info'); }	// delete the current file
		exec('mv temp/All_Data.gene_info ../resources');													// move the new file
	}
	
	// third step, remove the temporary directory and run the GLAD4U install script
	exec('rm -R temp/');
	exec('rm ../*');
	exec('perl install.pl');
	
	// fourth and last step, update the dates in the update files, put the site back online
	$fp = fopen ("../../update_core_glad4u.txt", "w+");
	fwrite($fp, date('m/d/Y'));
	fclose ($fp);

	$fp = fopen('../../index.php', 'w+') or die('Cannot open index.php. Automatic update cannot be done. Contact the System Administrator');
	fwrite($fp, $normal);
	fclose($fp);

	die;


/************************************
*	FUNCTIONS						*
*************************************/

//checkTime()
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//	DESCRIPTION:																						//
//	checkTime() was designed to ensure compliance with the NCBI querying eUtils. 1 query every 0.4s.	//
//	METHODS:																							//
//	First check if the file exists.																		//
//	If it does, it checks the difference between now and the time of the last query.					//
//	If the difference is more than 0.4s, authorize the query and update the time of the last query.		//
//	If the difference is less or equal to 0.4s, wait until the difference exceeds 0.4s.					//
//	If the file doesn't exist, create it.																//
//	ARGUMENTS:																							//
//	$now -> time																						//
//	OUTPUT:																								//
//	none																								//
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//	(c)2008-2010 - Bing Zhang, Jerome Jourquin - Dept. Biomedical Informatics, Vanderbilt University	//
//////////////////////////////////////////////////////////////////////////////////////////////////////////
function checkTime($now) {
	if (file_exists("../../time.txt")) {
		$last = file_get_contents("../../time.txt");
		while (($now - $last) < 0.4) {
			$now = microtime_float();
		}
	}
	$fp = fopen("../../time.txt", "w+");
	fputs($fp, microtime_float());
	fclose($fp);
}

//microtime_float()
/**
 * Simple function to replicate PHP 5 behaviour
 * http://us2.php.net/manual/en/function.microtime.php
 */
function microtime_float()
{
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

?>