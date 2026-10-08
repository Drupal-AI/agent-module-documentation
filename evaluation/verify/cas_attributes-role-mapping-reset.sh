#!/usr/bin/env bash
# Execution RESET: make sure the target role exists and clear every CAS Attributes role
# mapping, so the verify below fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("cas_attributes_task")) {
    Role::create(["id" => "cas_attributes_task", "label" => "CAS Attributes Task"])->save();
  }
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("role.mappings", [])
    ->set("role.sync_frequency", 0)
    ->set("role.deny_login_no_match", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: role cas_attributes_task exists, cas_attributes.settings role.mappings cleared"
