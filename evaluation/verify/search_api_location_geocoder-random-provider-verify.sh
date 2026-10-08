#!/usr/bin/env bash
# Execution VERIFY: PASS when a geocoder_provider with id starting 'salg_' and using the 'random'
# geocoder plugin exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("geocoder_provider");
  $hit = "none";
  foreach ($s->loadMultiple() as $id => $p) {
    if (strpos($id, "salg_") === 0 && $p->get("plugin") === "random") { $hit = $id; break; }
  }
  print (($hit !== "none") ? "PASS" : "FAIL") . " random_provider=" . $hit . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
