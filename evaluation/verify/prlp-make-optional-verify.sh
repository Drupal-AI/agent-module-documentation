#!/usr/bin/env bash
# Execution VERIFY: PASS when prlp.settings password_required === FALSE. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("prlp.settings")->get("password_required");
  $ok = ($v === FALSE);
  print ($ok ? "PASS" : "FAIL") . " password_required=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
