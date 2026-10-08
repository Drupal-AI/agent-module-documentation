#!/usr/bin/env bash
# Execution VERIFY (ui_styles_ui_patterns): PASS when the module is enabled AND the UI Patterns
# source manager registers the 'ui_styles_attributes' source (prop type 'attributes').
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("ui_styles_ui_patterns");
  $has = FALSE;
  if ($enabled && \Drupal::hasService("plugin.manager.ui_patterns_source")) {
    $has = \Drupal::service("plugin.manager.ui_patterns_source")->hasDefinition("ui_styles_attributes");
  }
  $ok = ($enabled && $has);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " source=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
