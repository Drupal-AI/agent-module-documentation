#!/usr/bin/env bash
# Introspection SETUP (cacheflush_ui): create a namespaced role cfu_role granted 'cacheflush clear
# any', so an agent can inspect roles and report the cacheflush permission it holds. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if(!Role::load("cfu_role")){Role::create(["id"=>"cfu_role","label"=>"CFU Role"])->save();}
  $r=Role::load("cfu_role"); $r->grantPermission("cacheflush clear any")->save();
' >/dev/null 2>&1
echo "setup: role cfu_role granted 'cacheflush clear any'"
