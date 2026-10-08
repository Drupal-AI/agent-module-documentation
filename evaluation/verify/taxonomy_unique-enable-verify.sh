#!/usr/bin/env bash
# Execution VERIFY: PASS when vocabulary tu_task has third_party_settings.taxonomy_unique.enabled === true.
# Pure config read. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::config("taxonomy.vocabulary.tu_task")->get("third_party_settings.taxonomy_unique.enabled");
  print (($e === TRUE) ? "PASS" : "FAIL") . " enabled=" . var_export($e, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
