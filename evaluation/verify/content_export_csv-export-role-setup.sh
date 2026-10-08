#!/usr/bin/env bash
# Introspection SETUP: create role cecsv_exporter granted the 'access content export' permission,
# so an inspecting agent can read back which role may use the Content Export CSV form. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cecsv_exporter") ?: Role::create(["id" => "cecsv_exporter", "label" => "CECSV Exporter"]);
  $r->grantPermission("access content export");
  $r->save();
' >/dev/null 2>&1
echo "setup: role cecsv_exporter has 'access content export'"
