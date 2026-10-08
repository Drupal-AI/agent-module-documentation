#!/usr/bin/env bash
# PASS when workflow buttons are restricted to the bottom only (display.top_buttons false).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("workflow_buttons.settings")->get("display.top_buttons");
  $ok = ($v === FALSE);
  print ($ok ? "PASS" : "FAIL") . " top_buttons=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
