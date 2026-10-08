#!/usr/bin/env bash
# Execution RESET: create role cecsv_team WITHOUT the 'access content export' permission, so verify
# FAILS until the agent grants it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cecsv_team") ?: Role::create(["id" => "cecsv_team", "label" => "CECSV Team"]);
  $r->revokePermission("access content export");
  $r->save();
' >/dev/null 2>&1
echo "reset: role cecsv_team present WITHOUT access content export"
