#!/usr/bin/env bash
# Execution VERIFY for "stop Config Override Warn from printing the overridden values".
# PASS when config_override_warn.settings:show_values is boolean FALSE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("config_override_warn.settings")->get("show_values");
  $ok = ($v === FALSE || $v === 0 || $v === "0");
  print ($ok ? "PASS" : "FAIL") . " show_values=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
