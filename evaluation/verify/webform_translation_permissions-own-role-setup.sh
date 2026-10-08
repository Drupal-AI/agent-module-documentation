#!/usr/bin/env bash
# Introspection SETUP: create a role wtp_own_role granted 'translate own webform' so an
# inspecting agent can read which webform-translation permission it holds. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("wtp_own_role")) { Role::create(["id" => "wtp_own_role", "label" => "WTP Own Role"])->save(); }
  $r = Role::load("wtp_own_role");
  $r->grantPermission("translate own webform");
  $r->save();
' >/dev/null 2>&1
echo "setup: role wtp_own_role has 'translate own webform'"
