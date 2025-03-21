<?php

#A bit Ugly...
if (count(debug_backtrace()) == 0) {
    throw new Exception("init.php, directly called. You shall not pass");
}

# composer
$composer = require_once 'vendor/autoload.php';


# have fun
echo "Hello World";
