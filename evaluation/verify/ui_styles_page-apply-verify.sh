#!/usr/bin/env bash
# Execution VERIFY (ui_styles_page): PASS when the default theme's 'content' region carries
# the CSS class 'ui-styles-eval-region2' via ui_styles_page (selected values or extra).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default") ?: "olivero";
  $regions = \Drupal::config($theme . ".settings")->get("third_party_settings.ui_styles_page.regions") ?: [];
  $c = $regions["content"] ?? [];
  $classes = \array_merge(\array_values($c["selected"] ?? []), \explode(" ", (string) ($c["extra"] ?? "")));
  $ok = \in_array("ui-styles-eval-region2", $classes, TRUE);
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
