<?php
$keys = [
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	0,
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z"
];
$key = $keys[(intval($args[0])-1)];
if(file_exists("../action-".$key.".php")) {
	include("../action-".$key.".php");
	echo "\nrem $key FOUND; EXECUTED";
} else {
	echo "rem $key NOT FOUND;";
}