#!/usr/bin/env bash
# Execution VERIFY: PASS when the role etc_role_dst exists and holds exactly the same
# permission set as etc_role_src (what entity_type_clone's role clone form produces via
# user_role_grant_permissions()). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $src = Role::load("etc_role_src");
  $dst = Role::load("etc_role_dst");
  if (!$src || !$dst) {
    print "FAIL src=" . var_export((bool) $src, TRUE) . " dst=" . var_export((bool) $dst, TRUE) . "\n";
    return;
  }
  $a = $src->getPermissions(); sort($a);
  $b = $dst->getPermissions(); sort($b);
  $ok = ($a === $b) && !empty($a);
  print ($ok ? "PASS" : "FAIL") . " src=[" . implode("|", $a) . "] dst=[" . implode("|", $b) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
