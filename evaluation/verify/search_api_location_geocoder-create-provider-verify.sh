#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one geocoder_provider entity with an id starting 'salg_'
# exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("geocoder_provider");
  $ids = [];
  foreach ($s->loadMultiple() as $id => $p) { if (strpos($id, "salg_") === 0) { $ids[] = $id; } }
  print (count($ids) ? "PASS" : "FAIL") . " salg_providers=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
