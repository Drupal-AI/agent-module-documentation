#!/usr/bin/env bash
# Execution RESET for "provide whitelist patterns from a module hook".
# Uninstalls (pmu FIRST, then delete the directory — an enabled module whose directory is
# gone makes the kernel fatal) and removes web/modules/custom/cr_eval_whitelist, and strips
# any settings.php whitelist so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush pmu cr_eval_whitelist -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/cr_eval_whitelist

php -r '
$f = $argv[1];
$s = file_get_contents($f);
$s = preg_replace("#\n?// BEGIN config_readonly eval.*?// END config_readonly eval[^\n]*\n?#s", "\n", $s);
$s = preg_replace("#\n?\\\$settings\\[.config_readonly_whitelist_patterns.\\]\s*=\s*\[.*?\];\n?#s", "\n", $s);
file_put_contents($f, $s);
' web/sites/default/settings.php

echo "reset: cr_eval_whitelist uninstalled+removed, settings.php whitelist cleared"
