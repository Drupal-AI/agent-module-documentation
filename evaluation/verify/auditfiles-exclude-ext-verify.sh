#!/usr/bin/env bash
# Execution VERIFY: PASS when auditfiles_exclude_extensions contains 'tmp'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("auditfiles.settings")->get("auditfiles_exclude_extensions");
  $ok = in_array("tmp", array_map("trim", preg_split("/[;,\s]+/", $v, -1, PREG_SPLIT_NO_EMPTY)), TRUE);
  print ($ok ? "PASS" : "FAIL") . " exclude_extensions=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
