#!/usr/bin/env bash
# Execution VERIFY: PASS when user 1's filter_perms selection uses the ALL_OPTIONS value (-1) for
# both roles and modules. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::keyValueExpirable("filter_perms_list")->get("1");
  if (!is_array($v)) { print "FAIL no-selection\n"; return; }
  $roles = array_map("strval", $v["roles"] ?? []);
  $modules = array_map("strval", $v["modules"] ?? []);
  $ok = in_array("-1", $roles, TRUE) && in_array("-1", $modules, TRUE);
  print ($ok ? "PASS" : "FAIL") . " roles=" . implode(",", $roles) . " modules=" . implode(",", $modules) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
