<?php
/* Autoloader for dev-php/symfony-config and its dependencies */

$vendor_dir = '/usr/share/php';

if (!class_exists('Fedora\\Autoloader\\Autoload', false)) {
  require_once("${vendor_dir}/Fedora/Autoloader/autoload.php");
}

\Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Config\\', __DIR__);

// Dependencies
\Fedora\Autoloader\Dependencies::required(array(
  "${vendor_dir}/Symfony/Component/Filesystem/autoload.php"
));
