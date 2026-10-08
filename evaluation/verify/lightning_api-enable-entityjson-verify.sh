#!/usr/bin/env bash
# Execution VERIFY: PASS when lightning_api.settings entity_json === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("lightning_api.settings")->get("entity_json");
  print (($v===TRUE) ? "PASS" : "FAIL") . " entity_json=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
