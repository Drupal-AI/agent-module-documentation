#!/usr/bin/env bash
# Execution VERIFY: PASS when admin_theme.settings exclude_paths includes /node/add.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = (string) \Drupal::config("admin_theme.settings")->get("exclude_paths");
  $ok = (strpos($p, "/node/add") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exclude_paths=" . str_replace("\n", "|", $p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
