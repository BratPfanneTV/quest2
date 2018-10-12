<?php
foreach(scandir(".") as $file) {
	if(substr($file, -15)=="CONNECTION_PING") {
		echo "echo $file ^> ".file_get_contents($file)."\n";
	}
}