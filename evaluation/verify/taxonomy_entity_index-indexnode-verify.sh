#!/usr/bin/env bash
# Execution VERIFY: PASS when 'node' is among the configured indexed types.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("taxonomy_entity_index.settings")->get("types") ?: [];
  $ok = in_array("node", array_values($t), TRUE);
  print ($ok ? "PASS" : "FAIL") . " types=" . implode(",", array_values($t)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
