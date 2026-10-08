#!/usr/bin/env bash
# Introspection SETUP: create a role and configure Registration Role to assign it, in the
# mode that also covers administrator-created accounts, so an agent can read it back off the
# live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("registration_role_known")) {
    Role::create(["id" => "registration_role_known", "label" => "Registration Role Known"])->save();
  }
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", ["registration_role_known" => "registration_role_known"])
    ->set("registration_mode", "admin")
    ->save();
' >/dev/null 2>&1
echo "setup: registration_role.setting assigns registration_role_known, mode=admin"
