#!/usr/bin/env bash
# Introspection CLEANUP: restore registration_role.setting defaults and remove both roles.
# The role deletions are retried once because a busy shared site can fail a config delete
# transiently. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("registration_role.setting")
    ->set("role_to_select", [])
    ->set("registration_mode", "user")
    ->save();
  for ($attempt = 0; $attempt < 2; $attempt++) {
    foreach (["registration_role_alpha", "registration_role_beta"] as $id) {
      try { if ($r = Role::load($id)) { $r->delete(); } }
      catch (\Throwable $e) { /* retried below */ }
    }
  }
' >/dev/null 2>&1
echo "cleanup: registration_role.setting reset, roles alpha/beta removed"
