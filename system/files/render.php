<?php
include("../textures.php");
$world = file_get_contents("loadworld.bat");
$world = json_decode($world, true);
$steps = range(-2,4,2);

$row=str_repeat(" ", (count($world[0])+($CONFIGS["SCREENSIZEY"]*2)));
$row.="\n";
$appendl=str_repeat(" ", $CONFIGS["SCREENSIZEY"]);
$appendt=str_repeat($row, $CONFIGS["SCREENSIZEX"]);

foreach($steps as $renderlevel) {
	$l1=$renderlevel;
	$l2=$renderlevel+1;
	$render=$appendt;
	foreach($world[$l1] as $x=>$arr) {
		$render.=$appendl;
		foreach($arr as $y=>$char) {
			if(isset($world[$l2][$x][$y]) and $world[$l2][$x][$y]!="main:air") {
				$obj=$world[$l2][$x][$y];
			} else {
				$obj = $char;
			}
			if(empty($obj)) {
				$obj="main:air";
			}
			if(isset($textures[$obj])) {
				$obj=$textures[$obj];
			} else {
				$obj="E";
			}
			$render.=$obj;
		}
		$render.=$appendl."\n";
	}
	$render.=$appendt;
	file_put_contents("L".$l1.".CHAR_RENDER", $render);
}