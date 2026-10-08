#!/usr/bin/env bash
# Introspection CLEANUP: strip the whitelist block added by the matching setup from
# settings.php, restoring the baseline (no config_readonly_whitelist_patterns).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

php -r '
$f = $argv[1];
$s = file_get_contents($f);
$s = preg_replace("#\n?// BEGIN config_readonly eval whitelist-lookup.*?// END config_readonly eval whitelist-lookup\n?#s", "\n", $s);
file_put_contents($f, $s);
' web/sites/default/settings.php

echo "cleanup: config_readonly whitelist block removed from settings.php"
