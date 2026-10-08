#!/usr/bin/env bash
# Execution CLEANUP: restore registration_role.setting defaults, remove the task role and any
# leftover probe user. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [])
    ->set("registration_mode", "user")
    ->save();
  if ($u = user_load_by_name("rr_verify_probe")) { $u->delete(); }
  if ($r = Role::load("registration_role_task")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: registration_role.setting reset, role registration_role_task and probe user removed"
