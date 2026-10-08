#!/usr/bin/env bash
# Execution VERIFY: PASS when field_sl_image's component in
# core.entity_view_display.node.article.default has settings.media_switch === 'slick_lightbox'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_sl_image") : NULL;
  $ms = $c["settings"]["media_switch"] ?? NULL;
  print (($ms === "slick_lightbox") ? "PASS" : "FAIL") . " type=" . ($c["type"] ?? "none") . " media_switch=" . var_export($ms, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
