<?php
$pathname="/media/storage/www/NetGalaxyWorld/public/uploads/admin/images";
$iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($pathname), RecursiveIteratorIterator::SELF_FIRST);
foreach($iterator as $item) {
    var_dump($item);
    chmod($item, 775);
    chgrp($item, "admin");
}




