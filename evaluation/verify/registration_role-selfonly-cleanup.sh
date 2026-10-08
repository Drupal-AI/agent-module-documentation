#!/usr/bin/env bash
# Execution CLEANUP: restore registration_role.setting defaults, remove the role and any
# leftover probe user. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [])
    ->set("registration_mode", "user")
    ->save();
  if ($u = user_load_by_name("rr_selfonly_probe")) { $u->delete(); }
  if ($r = Role::load("registration_role_selfonly")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: registration_role.setting reset, role registration_role_selfonly and probe user removed"
