#!/usr/bin/env bash
# Execution VERIFY: PASS when role unp_any_task_role holds 'view unpublished content'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("unp_any_task_role");
  $ok = $r && in_array("view unpublished content", $r->getPermissions(), TRUE);
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? $r->id() : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
