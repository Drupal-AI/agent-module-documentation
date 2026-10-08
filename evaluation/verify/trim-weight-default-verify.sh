#!/usr/bin/env bash
# Execution VERIFY: PASS only when Trim's module weight equals its EXACT shipped install
# default of 1001 (set by trim_install() via module_set_weight). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("core.extension")->get("module.trim");
  $ok = ((int) $w === 1001);
  print ($ok ? "PASS" : "FAIL") . " trim_weight=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
