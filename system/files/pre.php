<?php
$s = microtime(true);
$lagexception = [
	"loadworld"
];
if(!in_array($argv[1], $lagexception)) {
	set_time_limit(1);
}
chdir("system/files/tmp");
if(!file_exists("../data/USERNAME.DAT")) {
	file_put_contents("../data/USERNAME.DAT", "PLAYER".rand(10000,99999));
}
$CONFIGS = [
	"IP" => "213.202.229.164",
	"PORT" => "80",
	"WORLD" => "WORLD",
	"USERNAME" => "PLAYER",
	"SCREENSIZEX" => 41,
	"SCREENSIZEY" => 61
];
foreach($CONFIGS as $key=>$dvalue) {
	if(file_exists("../data/".$key.".DAT")) {
		$CONFIGS[$key]=trim(file_get_contents("../data/".$key.".DAT"));
	}
}
$args=explode(" ", $argv[2]);
$GLOBALS["func"]=$argv[1];
include($argv[1].".php");
$s = microtime(true)-$s;
$s = $s*1000;
if($s>100) {
	file_put_contents(".WARNING", "WARNING: Encountered big delay in client action ^<".$argv[1]."^> (".$s.")");
}
file_put_contents($argv[1].".CONNECTION_PING", $s);

function texture($obj) {
	include("textures.php");
	if(isset($textures[$obj])) {
		return $textures[$obj];
	} else {
		return "E";
	}
}
function http_queue($file, $args, $mode) {
	if(!is_dir("HTTP_QUEUE")) {
		mkdir("HTTP_QUEUE");
	}
	$id=count(scandir("HTTP_QUEUE"))-2;
	file_put_contents("HTTP_QUEUE/$id", json_encode([$file, $args, $mode, $GLOBALS["func"]], JSON_PRETTY_PRINT));
}


?>