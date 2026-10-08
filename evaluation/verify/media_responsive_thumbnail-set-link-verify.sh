#!/usr/bin/env bash
# Execution VERIFY for "set field_mrt_media's Responsive thumbnail formatter to link to the
# media item". PASS when node.mrt_ct.default's field_mrt_media component is still
# media_responsive_thumbnail AND settings.image_link === 'media'. Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.mrt_ct.default");
  $c = $vd ? $vd->getComponent("field_mrt_media") : NULL;
  $type = $c["type"] ?? "none";
  $link = $c["settings"]["image_link"] ?? "none";
  $ok = ($type === "media_responsive_thumbnail" && $link === "media");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " image_link=" . $link . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
