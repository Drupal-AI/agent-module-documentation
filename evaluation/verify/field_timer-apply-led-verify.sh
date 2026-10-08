#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ft_led in core.entity_view_display.node.article.default
# uses type field_timer_countdown_led with settings.countdown_theme === 'blue'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ft_led") : NULL;
  $type = $c["type"] ?? NULL;
  $theme = $c["settings"]["countdown_theme"] ?? NULL;
  $ok = ($type === "field_timer_countdown_led") && ($theme === "blue");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " countdown_theme=" . var_export($theme, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
