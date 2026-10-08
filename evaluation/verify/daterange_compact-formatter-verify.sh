#!/usr/bin/env bash
# Execution VERIFY (daterange_compact formatter): PASS when field_dc_range on Article is
# displayed with the daterange_compact ("Compact") formatter in the default view display.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_dc_range") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "daterange_compact");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
