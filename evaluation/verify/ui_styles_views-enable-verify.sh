#!/usr/bin/env bash
# Execution VERIFY (ui_styles_views): PASS when the module is enabled AND 'ui_styles' is listed
# in views.settings.display_extenders (i.e. the Views display extender is active site-wide).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("ui_styles_views");
  $exts = \Drupal::config("views.settings")->get("display_extenders") ?: [];
  $ok = $enabled && \in_array("ui_styles", $exts, TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " list=" . \implode(",", $exts) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
