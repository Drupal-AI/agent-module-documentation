#!/usr/bin/env bash
# Execution VERIFY for "switch field_mrt_media to the Responsive thumbnail formatter with
# responsive_image_style=mrt_style". PASS when node.mrt_ct.default's field_mrt_media
# component type is media_responsive_thumbnail AND settings.responsive_image_style is
# mrt_style. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.mrt_ct.default");
  $c = $vd ? $vd->getComponent("field_mrt_media") : NULL;
  $type = $c["type"] ?? "none";
  $style = $c["settings"]["responsive_image_style"] ?? "none";
  $ok = ($type === "media_responsive_thumbnail" && $style === "mrt_style");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " responsive_image_style=" . $style . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
