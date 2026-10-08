#!/usr/bin/env bash
# Execution VERIFY: PASS when the body component of core.entity_view_display.block_content.
# drag_and_drop_block.default uses the DXPR Builder formatter (type === "dxpr_builder_text").
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("block_content.drag_and_drop_block.default");
  $c = $vd ? $vd->getComponent("body") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "dxpr_builder_text");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
