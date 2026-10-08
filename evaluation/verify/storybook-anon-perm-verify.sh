#!/usr/bin/env bash
# Execution VERIFY: PASS when the anonymous role has the 'render storybook stories' permission.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("anonymous");
  $ok = $r && $r->hasPermission("render storybook stories");
  print ($ok ? "PASS" : "FAIL") . " anonymous_has_perm=" . var_export((bool)$ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
