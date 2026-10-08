#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("sfmu_task")) { $r->delete(); }
  Role::create(["id" => "sfmu_task", "label" => "sfmu_task"])->save();
' >/dev/null 2>&1
echo "reset: role sfmu_task exists without mapping permission"
