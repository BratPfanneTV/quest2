<?php
include("../textures.php");
$level = intval($args[0]);
$world = file_get_contents("loadworld.bat");
$world = json_decode($world, true);
$stdata = file_get_contents("stdata.json");
$stdata = json_decode($stdata, true);
$renderoverwrite[$stdata["L"]][$stdata["x"]][$stdata["y"]]="entity:player";
echo "set blockXa=";
echo ($world[$stdata["L"]][$stdata["x"]+1][$stdata["y"]]!="main:air") ? "true" : "false";
echo "\n";
echo "set blockXb=";
echo ($world[$stdata["L"]][$stdata["x"]-1][$stdata["y"]]!="main:air") ? "true" : "false";
echo "\n";
echo "set blockYa=";
echo ($world[$stdata["L"]][$stdata["x"]][$stdata["y"]+1]!="main:air") ? "true" : "false";
echo "\n";
echo "set blockYb=";
echo ($world[$stdata["L"]][$stdata["x"]][$stdata["y"]-1]!="main:air") ? "true" : "false";
echo "\n";
$world1 = $world[($level-9)];
$world = $world[($level-10)];
unset($world);
unset($world1);
echo "Cls\n";
$screensizeX = $CONFIGS["SCREENSIZEX"];
$screensizeY = $CONFIGS["SCREENSIZEY"];
$wallicon = "²";
$wall = str_repeat($wallicon, $screensizeY+2);
$rangeX = range(1,$screensizeX);
if($screensizeX==$screensizeY) {
	$rangeY=$rangeX;
} else {
	$rangeY=range(1,$screensizeY);
}
$renderlines=file("L".($level-10).".CHAR_RENDER", FILE_IGNORE_NEW_LINES);
$lines=array_slice($renderlines, ($stdata["x"]-ceil($screensizeX/2)+$screensizeX), $screensizeX, true);

if((time()-filemtime(".WARNING"))>5) {
	file_put_contents(".WARNING", " ");
}

$appendline[0]=file_get_contents(".WARNING");

$appendline[2]="X: ".$stdata["x"];
$appendline[3]="Y: ".$stdata["y"];

$cping=number_format(file_get_contents("showscreen.CONNECTION_PING"), 0);
$aping=number_format(file_get_contents("action.CONNECTION_PING"), 0);
$sping=number_format(file_get_contents("serverlogin.CONNECTION_PING"), 0);

$cping+=$aping;

$appendline[5]="Clientloop: ".$cping." ms";
$appendline[6]="Serverping: ".$sping." ms";
$appendline[7]=" Total Delay: ".($sping+$cping)." ms";

$appendline[9]="Logged in as: ".$CONFIGS["USERNAME"];

$appendline[11]="Prerender-Overwrite: ".number_format(count($renderoverwrite, 1)/100, 2)."%%";
$appendline[12]="HTTP-Cache-Usage: ".number_format((count(scandir("HTTP_QUEUE"))-2)*5, 2)."%%";
if(count(scandir("HTTP_QUEUE"))>22) {
	echo 'powershell (New-Object -ComObject Wscript.Shell).Popup("""Too many packages sent!""",0,"""Disconnected""",0x110)>response.txt'."\n";
	echo 'exit'."\n";
}
echo "echo ".$wall." ".$appendline[0]."\n";
foreach($rangeX as $x) {
	echo "echo.".$wallicon; 
	$dx = $x + ($stdata["x"]-ceil($screensizeX/2)) - 1 + $screensizeX;
	$wx = $dx + 1 - $screensizeX;
	
	// foreach($rangeY as $y) {
		// $dy = $y + ($stdata["y"]-ceil($screensizeY/2));
		// if(isset($world1[$dx][$dy]) and $world1[$dx][$dy]!="main:air") {
			// $d=$world1[$dx][$dy];
		// } else {
			// $d=$world[$dx][$dy];
		// }
		// if(empty($d)) {
			// $d=" ";
		// } else {
			// if(isset($textures[$d])) {
				// $d=$textures[$d];
			// } else {
				// $d="E";
			// }
		// }
		// echo $d;
	// }
	
	$row = substr($lines[$dx], ($stdata["y"]-ceil($screensizeY/2)+$screensizeY), $screensizeY);
	if(is_array($renderoverwrite[($level-10)])) {
		if(is_array($renderoverwrite[$wx])) {
			foreach($renderoverwrite[$wx] as $wy=>$o) {
				$row = substr_replace($row, texture($o), ($wy-$stdata["y"]+ceil($screensizeY/2)-2), 1);
			}
		}
	}
	if(is_array($renderoverwrite[($level-9)])) {
		if(is_array($renderoverwrite[($level-9)][$wx])) {
			foreach($renderoverwrite[($level-9)][$wx] as $wy=>$o) {
				$row = substr_replace($row, texture($o), ($wy-$stdata["y"]+ceil($screensizeY/2)-2), 1);
			}
		}
	}
	echo $row;
	
	echo $wallicon." ".$appendline[$x]."\n";
}
echo "echo ".$wall." ".$appendline[1000]."\n";
?>