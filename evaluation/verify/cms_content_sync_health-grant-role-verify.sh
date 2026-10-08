#!/usr/bin/env bash
# Execution VERIFY: PASS when role ccs_health_viewer exists with 'access sync health'. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ccs_health_viewer");
  $ok = ($r && $r->hasPermission("access sync health"));
  print ($ok ? "PASS" : "FAIL") . " role=" . var_export((bool)$r, TRUE) . " perm=" . var_export($r ? $r->hasPermission("access sync health") : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
