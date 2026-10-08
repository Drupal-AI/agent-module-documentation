#!/usr/bin/env bash
# Execution VERIFY: PASS when tu_msg has taxonomy_unique enabled === true AND message
# === 'TU no duplicates allowed'. Pure config read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("taxonomy.vocabulary.tu_msg")->get("third_party_settings.taxonomy_unique");
  $en = $c["enabled"] ?? NULL; $msg = $c["message"] ?? NULL;
  $ok = ($en === TRUE && $msg === "TU no duplicates allowed");
  print (($ok) ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . " message=" . var_export($msg, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
