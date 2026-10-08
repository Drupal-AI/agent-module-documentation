#!/usr/bin/env bash
# Execution VERIFY: PASS when field_erfl_task on node.article.default uses the
# entity_reference_facet_link formatter.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_erfl_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_facet_link");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
