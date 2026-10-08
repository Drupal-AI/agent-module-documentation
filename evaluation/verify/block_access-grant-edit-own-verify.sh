#!/usr/bin/env bash
# Execution VERIFY: PASS when ba_edit_role has 'update own basic block_content' AND does NOT
# have 'administer blocks'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ba_edit_role");
  $has = $r && $r->hasPermission("update own basic block_content");
  $admin = $r && $r->hasPermission("administer blocks");
  $ok = $has && !$admin;
  print ($ok ? "PASS" : "FAIL") . " has_update_own=" . var_export((bool)$has, TRUE) . " administer_blocks=" . var_export((bool)$admin, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
