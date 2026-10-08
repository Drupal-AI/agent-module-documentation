#!/usr/bin/env bash
# Execution VERIFY: PASS when field_mfp_task2 component is magnific_popup with
# settings.popup_image_style == large AND settings.gallery_type == separate_items.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_mfp_task2") : NULL;
  $type = $c["type"] ?? "none";
  $p = $c["settings"]["popup_image_style"] ?? NULL;
  $g = $c["settings"]["gallery_type"] ?? NULL;
  $ok = ($type === "magnific_popup" && $p === "large" && $g === "separate_items");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " popup=" . var_export($p, TRUE) . " gallery=" . var_export($g, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
