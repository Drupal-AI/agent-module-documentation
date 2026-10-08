#!/usr/bin/env bash
# Execution VERIFY: PASS when the Example Node Label component wrapper setting === "h5".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("extra_field_example_node_label") : NULL;
  $w = $c["settings"]["wrapper"] ?? "none";
  $ok = ($c && $w === "h5");
  print ($ok ? "PASS" : "FAIL") . " wrapper=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
