#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ic_task's Image formatter (default view mode) carries an
# image_class class containing "img-fluid".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ic_task") : NULL;
  $cls = $c["third_party_settings"]["image_class"]["class"] ?? "";
  $ok = is_string($cls) && strpos($cls, "img-fluid") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " class=" . var_export($cls, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
