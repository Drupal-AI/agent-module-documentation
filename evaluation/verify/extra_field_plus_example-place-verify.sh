#!/usr/bin/env bash
# Execution VERIFY: PASS when the Example Node Label extra field (component
# extra_field_example_node_label) is placed on the Article default display, in a visible region.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("extra_field_example_node_label") : NULL;
  $ok = !empty($c);
  print ($ok ? "PASS" : "FAIL") . " placed=" . ($c ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
