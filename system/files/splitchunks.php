<?php
$world = file_get_contents("loadworld.bat");
$world = json_decode($world, true);
if(!is_dir("chunks")) {
	mkdir("chunks");
}
$screensizeX=$CONFIGS["SCREENSIZEX"];
$screensizeY=$CONFIGS["SCREENSIZEY"];
foreach(range(-2,4) as $l) {
	$chunksX[$l]=array_chunk($world[$l], $screensizeX, true);
	foreach($chunksX[$l] as $key=>$chunkX) {
		$fchunks[$l][$key]=array_chunk($chunkX, $screensizeY, true);
	}
}
print_r($fchunks);
foreach($fchunks as $key1=>$arr1) {
	foreach($arr1 as $key2=>$arr2) {
		foreach($arr2 as $key3=>$arr3) {
			file_put_contents("chunks/$key1.$key2.$key3.CHUNK", json_encode($arr3, JSON_PRETTY_PRINT));
		}
	}
}