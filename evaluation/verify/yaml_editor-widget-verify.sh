#!/usr/bin/env bash
# Live-state verification for the "enable the YAML editor widget on a field" task.
# The Article field `field_yaml_config` must use the yaml_editor widget on its default
# form display. Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_yaml_config") : NULL;
  $type = ($c && isset($c["type"])) ? $c["type"] : "(none)";
  $ok = ($type === "yaml_editor");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
