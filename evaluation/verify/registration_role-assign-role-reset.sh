#!/usr/bin/env bash
# Execution RESET: make sure the target role exists, restore registration_role.setting to its
# install defaults (no roles, self-registration only) and delete any leftover probe user, so
# the verify below fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;
  if (!Role::load("registration_role_task")) {
    Role::create(["id" => "registration_role_task", "label" => "Registration Role Task"])->save();
  }
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [])
    ->set("registration_mode", "user")
    ->save();
  foreach (user_load_by_name("rr_verify_probe") ? [user_load_by_name("rr_verify_probe")] : [] as $u) { $u->delete(); }
' >/dev/null 2>&1
echo "reset: role registration_role_task exists, registration_role.setting at defaults"
