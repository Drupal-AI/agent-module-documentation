#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ts_task in node.article.default uses the
# tiny_slider_field_formatter formatter.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ts_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "tiny_slider_field_formatter") ? "PASS" : "FAIL") . " formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
