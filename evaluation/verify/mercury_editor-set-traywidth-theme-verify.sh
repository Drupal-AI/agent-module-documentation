#!/usr/bin/env bash
# Execution VERIFY: PASS when dialog_tray_width===600 and edit_screen_theme==='claro'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("mercury_editor.settings");
  $ok = ((int) $c->get("dialog_tray_width") === 600) && ($c->get("edit_screen_theme") === "claro");
  print ($ok ? "PASS" : "FAIL") . " width=" . var_export($c->get("dialog_tray_width"), TRUE) . " theme=" . var_export($c->get("edit_screen_theme"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
