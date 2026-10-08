#!/usr/bin/env bash
# Execution VERIFY: PASS when enable_debug_mode===TRUE and selector==='.main-content'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("quicklink.settings");
  $dbg = $c->get("enable_debug_mode");
  $sel = (string) $c->get("selector");
  $ok = ($dbg === TRUE && $sel === ".main-content");
  print ($ok ? "PASS" : "FAIL") . " debug=" . var_export($dbg, TRUE) . " selector=" . var_export($sel, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
