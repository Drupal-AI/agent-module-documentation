#!/usr/bin/env bash
# Execution VERIFY: PASS when field_atc_task uses the addtocal_view formatter on the default display.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_atc_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "addtocal_view");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
