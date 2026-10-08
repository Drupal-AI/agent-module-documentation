#!/usr/bin/env bash
# Execution VERIFY: PASS when node.lbat_demo.default form display uses the
# layout_builder_at_copy widget on layout_builder__layout with settings.appearance = 'checked'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.lbat_demo.default");
  $c = $fd ? $fd->getComponent("layout_builder__layout") : NULL;
  $type = $c["type"] ?? "none";
  $appearance = $c["settings"]["appearance"] ?? "none";
  $ok = ($type === "layout_builder_at_copy" && $appearance === "checked");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " appearance=" . $appearance . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
