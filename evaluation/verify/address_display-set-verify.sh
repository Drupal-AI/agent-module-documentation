#!/usr/bin/env bash
# Execution VERIFY: PASS when field_addisp_task on node.article.default uses the
# address_display_formatter. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_addisp_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "address_display_formatter");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
