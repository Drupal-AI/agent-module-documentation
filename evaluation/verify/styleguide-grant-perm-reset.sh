#!/usr/bin/env bash
# Execution RESET: ensure role styleguide_viewer exists WITHOUT the 'view style guides'
# permission, so verify FAILS until the agent grants it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("styleguide_viewer");
  if (!$r) { $r = Role::create(["id"=>"styleguide_viewer","label"=>"Styleguide Viewer"]); }
  $r->revokePermission("view style guides");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role styleguide_viewer exists without 'view style guides'"
