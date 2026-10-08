#!/usr/bin/env bash
# Introspection CLEANUP: restore registration_role.setting install defaults and remove the
# role created by the setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [])
    ->set("registration_mode", "user")
    ->save();
  if ($r = Role::load("registration_role_known")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: registration_role.setting reset to defaults, role registration_role_known removed"
