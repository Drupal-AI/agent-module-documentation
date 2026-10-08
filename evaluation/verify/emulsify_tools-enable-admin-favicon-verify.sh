#!/usr/bin/env bash
# Execution VERIFY: PASS when olivero is in admin_theme_favicon_themes. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = (array) \Drupal::config("emulsify_tools.settings")->get("admin_theme_favicon_themes");
  $ok = in_array("olivero", $l, TRUE);
  print ($ok ? "PASS" : "FAIL") . " list=" . implode(",", $l) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
