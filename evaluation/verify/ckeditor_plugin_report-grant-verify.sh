#!/usr/bin/env bash
# Execution VERIFY: PASS when role ckpr_task holds 'view ckeditor plugin report'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ckpr_task");
  $ok = $r ? $r->hasPermission("view ckeditor plugin report") : FALSE;
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "ckpr_task" : "missing") . " hasPerm=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
