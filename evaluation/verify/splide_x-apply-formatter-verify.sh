#!/usr/bin/env bash
# Execution VERIFY: PASS when field_images on Article's default view display uses the splide_image
# formatter with the x_carousel optionset. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_images") : NULL;
  $type = $c["type"] ?? "none";
  $opt = $c["settings"]["optionset"] ?? NULL;
  $ok = ($type==="splide_image" && $opt==="x_carousel");
  print ($ok?"PASS":"FAIL")." formatter=".$type." optionset=".var_export($opt,TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
