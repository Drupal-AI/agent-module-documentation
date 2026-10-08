#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ft_task in core.entity_view_display.node.article.default
# uses type field_timer_simple_text with settings.type === 'timer'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ft_task") : NULL;
  $type = $c["type"] ?? NULL;
  $setting = $c["settings"]["type"] ?? NULL;
  $ok = ($type === "field_timer_simple_text") && ($setting === "timer");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " setting=" . var_export($setting, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
