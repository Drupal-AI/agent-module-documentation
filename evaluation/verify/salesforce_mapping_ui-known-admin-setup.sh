#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("sfmu_known")) { $r->delete(); }
  $r = Role::create(["id" => "sfmu_known", "label" => "sfmu_known"]);
  $r->grantPermission("administer salesforce mapping");
  $r->save();
' >/dev/null 2>&1
echo "setup: role sfmu_known granted 'administer salesforce mapping'"
