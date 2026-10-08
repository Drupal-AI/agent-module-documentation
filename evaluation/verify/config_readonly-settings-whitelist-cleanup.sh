#!/usr/bin/env bash
# Execution CLEANUP for "whitelist config in settings.php".
# Strips any config_readonly whitelist block from settings.php so
# $settings['config_readonly_whitelist_patterns'] is unset and verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

php -r '
$f = $argv[1];
$s = file_get_contents($f);
// Remove any eval-authored marker blocks.
$s = preg_replace("#\n?// BEGIN config_readonly eval.*?// END config_readonly eval[^\n]*\n?#s", "\n", $s);
// Remove any bare whitelist assignment (however the agent wrote it last time).
$s = preg_replace("#\n?\\\$settings\\[.config_readonly_whitelist_patterns.\\]\s*=\s*\[.*?\];\n?#s", "\n", $s);
file_put_contents($f, $s);
' web/sites/default/settings.php

echo "cleanup: config_readonly_whitelist_patterns removed from settings.php"
