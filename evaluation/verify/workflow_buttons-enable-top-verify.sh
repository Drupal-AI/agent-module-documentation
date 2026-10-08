#!/usr/bin/env bash
# PASS when workflow buttons are configured to show at top AND bottom (display.top_buttons true).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("workflow_buttons.settings")->get("display.top_buttons");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " top_buttons=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
