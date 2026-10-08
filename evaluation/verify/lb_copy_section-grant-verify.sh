#!/usr/bin/env bash
# Execution VERIFY: PASS when role lbcs_grant has the 'copy paste sections' permission.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("lbcs_grant");
  $ok = $r && $r->hasPermission("copy paste sections");
  print ($ok ? "PASS" : "FAIL") . " lbcs_grant_has_perm=" . var_export((bool) $ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
