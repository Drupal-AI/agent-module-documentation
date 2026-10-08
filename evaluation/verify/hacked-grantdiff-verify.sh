#!/usr/bin/env bash
# Execution VERIFY: PASS when role hacked_diff_role holds 'view diffs of changed files'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hacked_diff_role");
  $ok = $r && in_array("view diffs of changed files", $r->getPermissions(), TRUE);
  print ($ok ? "PASS" : "FAIL") . " has_diff_perm=" . var_export((bool) $ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
