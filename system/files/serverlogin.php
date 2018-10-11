<?php
$file = json_decode(file_get_contents("http://".$CONFIGS["IP"].":".$CONFIGS["PORT"]."/server/serverlogin.php?world=".$CONFIGS["WORLD"]."&player=".$CONFIGS["USERNAME"]), true);
file_put_contents("stdata.json", json_encode($file, JSON_PRETTY_PRINT));
?>