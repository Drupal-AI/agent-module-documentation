#!/usr/bin/env bash
# Execution RESET: (re)create role lbcs_grant WITHOUT the 'copy paste sections' permission, so
# verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("lbcs_grant")) { $r->delete(); }
  Role::create(["id"=>"lbcs_grant","label"=>"LBCS Grant"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role lbcs_grant exists WITHOUT 'copy paste sections'"
