#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article.default field_fis_wimg component uses
# image_style_image_formatter with field_image_style === field_fis_wsrc. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fis_wimg") : NULL;
  $type = $c["type"] ?? "none";
  $src = $c["settings"]["field_image_style"] ?? "";
  $ok = ($type === "image_style_image_formatter" && $src === "field_fis_wsrc");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " field_image_style=" . var_export($src, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
