#!/usr/bin/env bash
# Introspection SETUP: create a role tmt_bulk and grant it the bulk-delete permission so an
# agent can read back which role can multi-delete terms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("tmt_bulk")) {
    Role::create(["id" => "tmt_bulk", "label" => "TMT Bulk"])->save();
  }
  $r = Role::load("tmt_bulk");
  $r->grantPermission("access taxonomy multidelete terms");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role tmt_bulk has 'access taxonomy multidelete terms'"
