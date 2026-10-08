#!/usr/bin/env bash
# Introspection CLEANUP: restore cas_attributes.settings to its install defaults and remove
# the role created by the setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("sitewide_token_support", FALSE)
    ->set("token_allowed_attributes", [])
    ->set("field.sync_frequency", 0)
    ->set("field.overwrite", FALSE)
    ->set("field.mappings", [])
    ->set("role.sync_frequency", 0)
    ->set("role.deny_login_no_match", FALSE)
    ->set("role.deny_registration_no_match", FALSE)
    ->set("role.mappings", [])
    ->save();
  if ($r = Role::load("cas_attributes_known")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: cas_attributes.settings back to defaults, role cas_attributes_known removed"
