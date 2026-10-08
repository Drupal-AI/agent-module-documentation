#!/usr/bin/env bash
# Execution VERIFY: PASS when the field_bps_task component in the Article default view display
# uses a Blazy-family formatter with settings.media_switch === "photoswipe".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_bps_task") : NULL;
  $sw = $c["settings"]["media_switch"] ?? NULL;
  $ok = ($sw === "photoswipe");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . ($c["type"] ?? "none") . " media_switch=" . var_export($sw, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
