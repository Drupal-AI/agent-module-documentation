#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ifs_effect uses the slideshow formatter AND its
# imagefield_slideshow_style_effects setting is 'flipHorz'. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $d ? $d->getComponent("field_ifs_effect") : NULL;
  $type = $c["type"] ?? "none";
  $fx = $c["settings"]["imagefield_slideshow_style_effects"] ?? "none";
  $ok = ($type === "imagefield_slideshow_field_formatter" && $fx === "flipHorz");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " effect=" . var_export($fx, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
