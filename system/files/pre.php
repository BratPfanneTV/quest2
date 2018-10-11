<?php
set_time_limit(1);
chdir("system/files/tmp");
if(!file_exists("USERNAME.DAT")) {
	file_put_contents("USERNAME.DAT", "PLAYER".rand(10000,99999));
}
$CONFIGS = [
	"IP" => "213.202.229.164",
	"PORT" => "80",
	"WORLD" => "WORLD",
	"USERNAME" => "PLAYER",
	"SCREENSIZEX" => 31,
	"SCREENSIZEY" => 46
];
foreach($CONFIGS as $key=>$dvalue) {
	if(file_exists($key.".DAT")) {
		$CONFIGS[$key]=file_get_contents($key.".DAT");
	}
}
$args=explode(" ", $argv[2]);
include($argv[1].".php");
?>