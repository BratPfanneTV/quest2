<?php
include("../textures.php");
echo "rem ".getcwd()."\n";
$level = intval($args[0]);
$world = file_get_contents("loadworld.bat");
$world = json_decode($world, true);
$stdata = file_get_contents("stdata.json");
$stdata = json_decode($stdata, true);
$world[$stdata["L"]][$stdata["x"]][$stdata["y"]]="entity:player";
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
echo "rem ".($level-10)."\n";
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

$appendline[0]="X: ".$stdata["x"];
$appendline[1]="Y: ".$stdata["y"];

echo "echo ".$wall." ".$appendline[0]."\n";
foreach($rangeX as $x) {
	echo "echo ".$wallicon; 
	$row="";
	$dx = $x + ($stdata["x"]-ceil($screensizeX/2));
	if(false) {
		$lx=$stdata["y"]-ceil($screensizeY/2);
		$row=substr(file("L".($level-10).".CHAR_RENDER")[$dx], $lx, $screensizeY);
	} else {
		foreach($rangeY as $y) {
			$dy = $y + ($stdata["y"]-ceil($screensizeY/2));
			if(isset($world1[$dx][$dy]) and $world1[$dx][$dy]!="main:air") {
				$d=$world1[$dx][$dy];
			} else {
				$d=$world[$dx][$dy];
			}
			if(empty($d)) {
				$d="main:air";
			}
			if(isset($textures[$d])) {
				$d=$textures[$d];
			} else {
				$d="E";
			}
			echo $d;
		}
	}
	echo trim($wallicon)." ".$appendline[$x]."\n";
}
echo "echo ".$wall." ".$appendline[1000]."\n";
?>