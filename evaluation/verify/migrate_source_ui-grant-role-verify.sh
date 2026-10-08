#!/usr/bin/env bash
# Execution VERIFY: PASS when role migsui_task has the 'access migrate source ui' permission.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("migsui_task");
  $ok = $r && $r->hasPermission("access migrate source ui");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "migsui_task" : "MISSING") . " has_perm=" . var_export((bool) $ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
