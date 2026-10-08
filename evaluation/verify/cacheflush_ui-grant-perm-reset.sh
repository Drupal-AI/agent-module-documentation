#!/usr/bin/env bash
# Execution RESET (cacheflush_ui): create a namespaced role cfu_grant_role WITHOUT any cacheflush
# permission, so verify FAILS until the agent grants 'cacheflush clear any'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if($r=Role::load("cfu_grant_role")){$r->delete();}
  Role::create(["id"=>"cfu_grant_role","label"=>"CFU Grant Role"])->save();
' >/dev/null 2>&1
echo "reset: role cfu_grant_role has no cacheflush permission"
