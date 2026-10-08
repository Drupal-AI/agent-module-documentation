#!/usr/bin/env bash
# Execution VERIFY: PASS when type.node_contributor === 'admin'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("form_mode_manager_theme_switcher.settings")->get("type.node_contributor");
  $ok = ($v === "admin");
  print ($ok ? "PASS" : "FAIL") . " type.node_contributor=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
