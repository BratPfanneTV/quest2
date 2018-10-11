<?php
echo file_get_contents("http://".$CONFIGS["IP"].":".$CONFIGS["PORT"]."/server/get-world.php?world=".$CONFIGS["WORLD"]);
?>