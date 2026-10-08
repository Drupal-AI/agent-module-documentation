#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ctry_fmt is displayed with the country_iso_code formatter. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ctry_fmt") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "country_iso_code");
  print ($ok ? "PASS" : "FAIL") . " formatter=$type\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
