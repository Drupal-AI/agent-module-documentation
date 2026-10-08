#!/usr/bin/env bash
# Introspection CLEANUP: remove the conditional lock block added by the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

php -r '
$f = $argv[1];
$s = file_get_contents($f);
$s = preg_replace("#\n?// BEGIN config_readonly eval lock-state.*?// END config_readonly eval lock-state\n?#s", "\n", $s);
file_put_contents($f, $s);
' web/sites/default/settings.php

echo "cleanup: config_readonly lock-state block removed from settings.php"
