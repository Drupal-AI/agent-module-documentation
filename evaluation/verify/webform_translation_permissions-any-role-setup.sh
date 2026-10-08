#!/usr/bin/env bash
# Introspection SETUP: create a role wtp_any_role granted 'translate any webform' so an
# inspecting agent can read which webform-translation permission it holds. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("wtp_any_role")) { Role::create(["id" => "wtp_any_role", "label" => "WTP Any Role"])->save(); }
  $r = Role::load("wtp_any_role");
  $r->grantPermission("translate any webform");
  $r->save();
' >/dev/null 2>&1
echo "setup: role wtp_any_role has 'translate any webform'"
