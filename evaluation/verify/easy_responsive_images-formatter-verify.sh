#!/usr/bin/env bash
# Execution VERIFY: PASS when the field_erim_img component in node.article.default view display
# uses the easy_responsive_images formatter. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_erim_img") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "easy_responsive_images");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
