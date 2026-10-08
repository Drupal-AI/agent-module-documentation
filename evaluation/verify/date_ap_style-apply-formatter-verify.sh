#!/usr/bin/env bash
# Execution VERIFY: PASS when the field_apstyle_probe component in the Article default view
# display uses the timestamp_ap_style formatter. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_apstyle_probe") : NULL;
  $type = $c["type"] ?? "none";
  print (($type==="timestamp_ap_style") ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
