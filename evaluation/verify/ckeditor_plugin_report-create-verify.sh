#!/usr/bin/env bash
# Execution VERIFY: PASS when role ckpr_build exists and holds 'view ckeditor plugin report'.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ckpr_build");
  $ok = $r ? $r->hasPermission("view ckeditor plugin report") : FALSE;
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $r, TRUE) . " hasPerm=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
