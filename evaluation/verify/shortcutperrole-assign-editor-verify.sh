#!/usr/bin/env bash
# Execution VERIFY (shortcutperrole): PASS when shortcutperrole.settings has role.content_editor
# explicitly set to the "default" shortcut set. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("shortcutperrole.settings")->get("role.content_editor");
  $ok = ($v === "default");
  print ($ok ? "PASS" : "FAIL") . " role.content_editor=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
