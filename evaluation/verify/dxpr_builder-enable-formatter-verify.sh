#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dxprb_body's component in core.entity_view_display.node.
# article.default uses the DXPR Builder formatter (type === "dxpr_builder_text"). Prints
# PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_dxprb_body") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "dxpr_builder_text");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
