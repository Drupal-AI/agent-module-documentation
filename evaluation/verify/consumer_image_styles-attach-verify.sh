#!/usr/bin/env bash
# Execution VERIFY: PASS when consumer 'cis_hard' has the 'thumbnail' image style attached.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cs = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id"=>"cis_hard"]);
  $c = reset($cs);
  $styles = $c ? array_column($c->get("image_styles")->getValue(), "target_id") : [];
  print (in_array("thumbnail", $styles, TRUE) ? "PASS" : "FAIL")." styles=".implode(",", $styles)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
