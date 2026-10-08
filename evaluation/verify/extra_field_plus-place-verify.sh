#!/usr/bin/env bash
# Execution VERIFY: PASS when the Example Node Label extra field is placed on Article default
# display with its wrapper setting === "h3".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("extra_field_example_node_label") : NULL;
  $w = $c["settings"]["wrapper"] ?? "none";
  $ok = ($c && $w === "h3");
  print ($ok ? "PASS" : "FAIL") . " placed=" . ($c ? "yes" : "no") . " wrapper=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
