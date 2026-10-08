#!/usr/bin/env bash
# Execution VERIFY: PASS when vwo.settings:id === 7654321. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $id = \Drupal::config("vwo.settings")->get("id");
  $ok = ((int) $id === 7654321);
  print ($ok ? "PASS" : "FAIL") . " id=" . var_export($id, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
