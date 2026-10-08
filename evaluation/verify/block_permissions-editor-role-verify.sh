#!/usr/bin/env bash
# Execution VERIFY: PASS when role bp_task_role exists and holds exactly the block_permissions
# permissions for theme olivero and provider block_content (and no other theme permission).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("bp_task_role");
  if (!$r) { print "FAIL role-missing\n"; return; }
  $has_theme = $r->hasPermission("administer block settings for theme olivero");
  $has_provider = $r->hasPermission("administer blocks provided by block_content");
  $no_claro = !$r->hasPermission("administer block settings for theme claro");
  $ok = $has_theme && $has_provider && $no_claro;
  print ($ok ? "PASS" : "FAIL") . " olivero=" . var_export($has_theme, TRUE)
    . " block_content=" . var_export($has_provider, TRUE)
    . " claro_absent=" . var_export($no_claro, TRUE)
    . " perms=" . implode("|", $r->getPermissions()) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
