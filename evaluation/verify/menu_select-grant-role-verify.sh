#!/usr/bin/env bash
# Execution VERIFY: PASS when role menu_select_navigator exists AND holds 'use menu select
# search'. exit 0 pass/1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("menu_select_navigator");
  $ok = $r && $r->hasPermission("use menu select search");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "yes" : "no") . " perm=" . var_export($r ? $r->hasPermission("use menu select search") : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
