#!/usr/bin/env bash
# Execution VERIFY: PASS when field_sgm_map is displayed with the styled_google_map_default
# formatter on core.entity_view_display.node.article.default. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_sgm_map") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "styled_google_map_default");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
