#!/usr/bin/env bash
# Execution VERIFY: PASS when field_mfp_task component type is magnific_popup with
# settings.gallery_type == all_items. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_mfp_task") : NULL;
  $type = $c["type"] ?? "none";
  $g = $c["settings"]["gallery_type"] ?? NULL;
  $ok = ($type === "magnific_popup" && $g === "all_items");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " gallery=" . var_export($g, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
