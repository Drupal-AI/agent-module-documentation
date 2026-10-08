#!/usr/bin/env bash
# Execution VERIFY: PASS when role tp_task holds the theme_permission dynamic permission
# 'administer themes claro'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tp_task");
  $ok = $r && in_array("administer themes claro", $r->getPermissions(), TRUE);
  print ($ok ? "PASS" : "FAIL")." perms=".($r ? implode("|", $r->getPermissions()) : "no-role")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
