#!/usr/bin/env bash
# Execution VERIFY (shortcutperrole, layman): PASS when role.authenticated is explicitly set to
# the "default" shortcut set in shortcutperrole.settings. Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("shortcutperrole.settings")->get("role.authenticated");
  $ok = ($v === "default");
  print ($ok ? "PASS" : "FAIL") . " role.authenticated=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
