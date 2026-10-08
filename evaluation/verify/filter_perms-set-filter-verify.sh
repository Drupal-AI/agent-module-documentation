#!/usr/bin/env bash
# Execution VERIFY: PASS when user 1's filter_perms selection shows only the User module and the
# fperm_reviewer role. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::keyValueExpirable("filter_perms_list")->get("1");
  if (!is_array($v)) { print "FAIL no-selection\n"; return; }
  $roles = $v["roles"] ?? [];
  $modules = $v["modules"] ?? [];
  $ok = in_array("fperm_reviewer", $roles, TRUE) && in_array("user", $modules, TRUE);
  print ($ok ? "PASS" : "FAIL") . " roles=" . implode(",", $roles) . " modules=" . implode(",", $modules) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
