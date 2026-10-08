#!/usr/bin/env bash
# Execution VERIFY: PASS when nodeorder.settings entity_list_limit === 10. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("nodeorder.settings")->get("entity_list_limit");
  $ok = ((int) $v === 10);
  print ($ok ? "PASS" : "FAIL") . " entity_list_limit=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
