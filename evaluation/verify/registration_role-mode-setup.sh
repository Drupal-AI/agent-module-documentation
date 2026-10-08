#!/usr/bin/env bash
# Introspection SETUP: assign two roles on registration but restrict it to self-registration
# only, so an agent has to read both keys of the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["registration_role_alpha" => "Registration Role Alpha", "registration_role_beta" => "Registration Role Beta"] as $id => $label) {
    if (!Role::load($id)) { Role::create(["id" => $id, "label" => $label])->save(); }
  }
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [
      "registration_role_alpha" => "registration_role_alpha",
      "registration_role_beta" => "registration_role_beta",
    ])
    ->set("registration_mode", "user")
    ->save();
' >/dev/null 2>&1
echo "setup: roles registration_role_alpha+beta assigned, registration_mode=user"
