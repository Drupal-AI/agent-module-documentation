#!/usr/bin/env bash
# Execution VERIFY: PASS when role styleguide_viewer has the 'view style guides' permission.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("styleguide_viewer");
  $ok = $r && $r->hasPermission("view style guides");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "exists" : "missing") . " has_perm=" . var_export($r ? $r->hasPermission("view style guides") : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
