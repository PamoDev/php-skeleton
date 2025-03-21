<?php

/** @var ClassLoader $composer */

use Composer\Autoload\ClassLoader;

$composer = require __DIR__ . '/../vendor/autoload.php';

// Add Tests as PSR-4 in Runtime
// $composer->addPsr2('Tests\\', 'tests/');
