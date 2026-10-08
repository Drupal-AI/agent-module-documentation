#!/usr/bin/env bash
# Execution VERIFY: PASS when the TEASER view mode's field_ic_teaser Image formatter carries an
# image_class class containing "teaser-thumb" (default view mode is not what is checked).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.teaser");
  $c = $vd ? $vd->getComponent("field_ic_teaser") : NULL;
  $cls = $c["third_party_settings"]["image_class"]["class"] ?? "";
  $ok = is_string($cls) && strpos($cls, "teaser-thumb") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " teaser_class=" . var_export($cls, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
