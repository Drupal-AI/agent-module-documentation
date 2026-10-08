#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("sfmu_view")) { $r->delete(); }
  $r = Role::create(["id" => "sfmu_view", "label" => "sfmu_view"]);
  $r->grantPermission("view salesforce mapping");
  $r->save();
' >/dev/null 2>&1
echo "setup: role sfmu_view granted 'view salesforce mapping'"
