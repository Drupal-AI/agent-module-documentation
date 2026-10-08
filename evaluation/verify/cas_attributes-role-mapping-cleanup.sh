#!/usr/bin/env bash
# Execution CLEANUP: clear the role mappings and remove the role created by the reset.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("role.mappings", [])
    ->set("role.sync_frequency", 0)
    ->set("role.deny_login_no_match", FALSE)
    ->save();
  if ($r = Role::load("cas_attributes_task")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role.mappings cleared, role cas_attributes_task removed"
