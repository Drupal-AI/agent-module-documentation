#!/usr/bin/env bash
# Execution VERIFY: PASS when the FORMATTED extra field on Article default display has
# link_to_entity === true.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("extra_field_example_node_label_formatted") : NULL;
  $l = $c["settings"]["link_to_entity"] ?? NULL;
  $ok = ($c && !empty($l));
  print ($ok ? "PASS" : "FAIL") . " placed=" . ($c ? "yes" : "no") . " link_to_entity=" . var_export($l, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
