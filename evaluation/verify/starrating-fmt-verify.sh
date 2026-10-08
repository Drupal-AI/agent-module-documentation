#!/usr/bin/env bash
# Execution VERIFY: PASS when field_srt_fmt's component in the Article default view display uses
# the starrating_value_rating formatter (the "8/10" text style). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_srt_fmt") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "starrating_value_rating") ? "PASS" : "FAIL") . " formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
