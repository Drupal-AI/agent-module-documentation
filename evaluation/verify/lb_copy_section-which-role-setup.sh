#!/usr/bin/env bash
# Introspection SETUP: create a role lbcs_editor that has the 'copy paste sections' permission
# so an inspecting agent can report which role may copy/paste Layout Builder sections.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("lbcs_editor") ?: Role::create(["id"=>"lbcs_editor","label"=>"LBCS Editor"]);
  $r->grantPermission("copy paste sections")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role lbcs_editor granted 'copy paste sections'"
