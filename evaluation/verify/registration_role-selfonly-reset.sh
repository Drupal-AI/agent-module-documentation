#!/usr/bin/env bash
# Execution RESET: make sure the target role exists and put registration_role.setting in a
# state that fails the verify -- the role IS assigned but in 'admin' mode, which is exactly
# what the task says must not happen. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("registration_role_selfonly")) {
    Role::create(["id" => "registration_role_selfonly", "label" => "Registration Role Self Only"])->save();
  }
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [])
    ->set("registration_mode", "admin")
    ->save();
  if ($u = user_load_by_name("rr_selfonly_probe")) { $u->delete(); }
' >/dev/null 2>&1
echo "reset: role registration_role_selfonly exists, no roles assigned, registration_mode=admin"
