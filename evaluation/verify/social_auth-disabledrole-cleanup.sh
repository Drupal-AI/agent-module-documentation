#!/usr/bin/env bash
# Introspection CLEANUP: remove the socialauth_blocked role and reset disabled_roles.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::configFactory()->getEditable("social_auth.settings")->set("disabled_roles", [])->save();
  if ($r = Role::load("socialauth_blocked")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: socialauth_blocked role removed, disabled_roles=[]"
