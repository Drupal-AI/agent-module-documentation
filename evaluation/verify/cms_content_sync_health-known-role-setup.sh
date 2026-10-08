#!/usr/bin/env bash
# Introspection SETUP: create role ccs_health_known and grant 'access sync health'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("ccs_health_known")) {
    Role::create(["id" => "ccs_health_known", "label" => "CCS Health Known"])->save();
  }
  $r = Role::load("ccs_health_known");
  $r->grantPermission("access sync health")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role ccs_health_known has 'access sync health'"
