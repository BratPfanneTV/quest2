<?php
echo file_get_contents("http://".$CONFIGS["IP"].":".$CONFIGS["PORT"]."/server/move.php?world=".$CONFIGS["WORLD"]."&mv=".$x."|".$y."&player=".$CONFIGS["USERNAME"]);
