#!/usr/bin/env bash
# Execution VERIFY: PASS when role ebp_task_role holds permission
# 'entity_bundle_permissions access node article'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ebp_task_role");
  $ok = $r && $r->hasPermission("entity_bundle_permissions access node article");
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
