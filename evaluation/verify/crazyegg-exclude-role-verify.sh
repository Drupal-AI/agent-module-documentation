#!/usr/bin/env bash
# Execution VERIFY: PASS when crazyegg_roles_excluded contains 'administrator'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $roles = (array) \Drupal::config("crazyegg.settings")->get("crazyegg_roles_excluded");
  $ok = in_array("administrator", $roles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " roles_excluded=" . implode(",", $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
