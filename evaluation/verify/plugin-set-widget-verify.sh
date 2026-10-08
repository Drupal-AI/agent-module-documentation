#!/usr/bin/env bash
# Execution VERIFY: PASS when field_plugin_wtask's component in the Article default form display
# uses a Plugin selector widget (type starts with "plugin_selector"). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_plugin_wtask") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($c && str_starts_with($type, "plugin_selector"));
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
