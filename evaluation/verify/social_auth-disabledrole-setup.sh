#!/usr/bin/env bash
# Introspection SETUP: create a role socialauth_blocked and disable social login for it via
# social_auth.settings disabled_roles, so an agent can read back which role is blocked.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("socialauth_blocked")) {
    Role::create(["id"=>"socialauth_blocked","label"=>"Social Auth Blocked"])->save();
  }
  \Drupal::configFactory()->getEditable("social_auth.settings")
    ->set("disabled_roles", ["socialauth_blocked" => "socialauth_blocked"])
    ->save();
' >/dev/null 2>&1
echo "setup: social login disabled for role socialauth_blocked"
