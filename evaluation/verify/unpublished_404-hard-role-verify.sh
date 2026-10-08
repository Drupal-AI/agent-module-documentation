#!/usr/bin/env bash
# Execution VERIFY: PASS when role u404_viewer exists AND has 'view own unpublished content'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("u404_viewer");
  $ok = ($r && $r->hasPermission("view own unpublished content"));
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "yes" : "no") . " perm=" . ($r && $r->hasPermission("view own unpublished content") ? "yes" : "no");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
