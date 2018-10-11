<?php
include("../textures.php");
$world = file_get_contents("loadworld.bat");
$world = json_decode($world, true);
$steps = range(-2,4,2);
foreach($steps as $renderlevel) {
	$l1=$renderlevel;
	$l2=$renderlevel+1;
	$render="";
	foreach($world[$l1] as $x=>$arr) {
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
		$render.="\n";
	}
	file_put_contents("L".$l1.".CHAR_RENDER", $render);
}