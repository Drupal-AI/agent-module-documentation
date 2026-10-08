#!/usr/bin/env bash
# Execution VERIFY: PASS when the media_crowdriff formatter on media.mc_fmt_type.default is
# configured to width=640px AND height=480px. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mc_fmt_type.default");
  $c = $vd ? $vd->getComponent("field_media_media_crowdriff") : NULL;
  $w = $c["settings"]["width"] ?? NULL; $h = $c["settings"]["height"] ?? NULL;
  $ok = ($c && ($c["type"] ?? "") === "media_crowdriff" && $w === "640px" && $h === "480px");
  print ($ok ? "PASS" : "FAIL") . " width=" . var_export($w, TRUE) . " height=" . var_export($h, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
