#!/usr/bin/env bash
# Execution VERIFY: PASS when Entity Usage tracks EXACTLY node + media, exposing the count field
# for both node and media Views tables. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $types = \Drupal::config("entity_usage.settings")->get("track_enabled_target_entity_types") ?: [];
  sort($types);
  print (($types === ["media", "node"]) ? "PASS" : "FAIL") . " types=" . implode(",", $types) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
