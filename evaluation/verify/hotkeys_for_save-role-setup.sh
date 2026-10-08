#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role hfs_role and grant it 'use hotkeys for save' so
# an agent can read back which role has the hotkeys permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hfs_role") ?: Role::create(["id"=>"hfs_role","label"=>"HFS Role"]);
  $r->grantPermission("use hotkeys for save");
  $r->save();
' >/dev/null 2>&1
echo "setup: role hfs_role granted 'use hotkeys for save'"
