#!/usr/bin/env bash
# Execution VERIFY: PASS when field_jf_out is rendered with the json_field "pretty" formatter
# on core.entity_view_display.node.article.default. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_jf_out") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "pretty");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
