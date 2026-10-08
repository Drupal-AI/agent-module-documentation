#!/usr/bin/env bash
# Execution VERIFY (ui_styles_entity_status): PASS when the default theme's unpublished-entity
# styles contain the CSS class 'ui-styles-eval-unpub2' (selected values or extra).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $s = \Drupal::config($theme . ".settings")->get("third_party_settings.ui_styles_entity_status.unpublished") ?: [];
  $classes = \array_merge(\array_values($s["selected"] ?? []), \explode(" ", (string) ($s["extra"] ?? "")));
  $ok = \in_array("ui-styles-eval-unpub2", $classes, TRUE);
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
