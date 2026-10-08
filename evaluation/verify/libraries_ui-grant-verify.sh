#!/usr/bin/env bash
# Execution VERIFY: PASS when role libraries_ui_task_role has the 'access libraries_ui' permission.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("libraries_ui_task_role");
  $ok = $r && $r->hasPermission("access libraries_ui");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "present" : "absent") . " hasPerm=" . var_export((bool) $ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
