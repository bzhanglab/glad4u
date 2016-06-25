<?php 

	echo '<p><a href="index.html" target="_top">HOME</a></p>';
	if ((isset($_GET)) && (array_key_exists('q', $_GET))) { $q = $_GET['q']; }
	if ($q=='all') {
		$dir = "../../outputs";
		$directory = opendir($dir); 
		while($item = readdir($directory)){ 
			echo "item: $item<br>";
		// We filter the elements that we don't want to appear ".", ".." and ".svn" 
			 if(($item != ".") && ($item != "..") && ($item != ".svn") ){ 
				if (is_dir($dir.'/'.$item)) {
					$subdir = opendir($dir.'/'.$item);
					while ($subitem = readdir($subdir)) {
						if (is_dir($dir.'/'.$item.'/'.$subitem)) {
							$subsubdir = opendir($dir.'/'.$item.'/'.$subitem);
							while ($subsubitem = readdir($subsubdir)) {
								echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subsubitem: $subsubitem<br>";
								 if (($subsubitem != ".") && ($subsubitem != "..") && ($subsubitem != ".svn")) { unlink($dir.'/'.$item.'/'.$subitem.'/'.$subsubitem); }
							}
							closedir($subsubdir);
							rmdir($dir.'/'.$item.'/'.$subitem);
						} else {					
							echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subitem: $subitem<br>";
							 if (($subitem != ".") && ($subitem != "..") && ($subitem != ".svn")) { unlink($dir.'/'.$item.'/'.$subitem); }
						}
					}
					closedir($subdir);
					rmdir($dir.'/'.$item);
				} else { unlink($dir.'/'.$item); }
			 } 
		} 
	}


?> 