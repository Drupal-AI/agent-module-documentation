#!/usr/bin/env bash
# Execution RESET: create role hfs_revoke that HAS 'use hotkeys for save' (verify FAILS until the
# permission is removed). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hfs_revoke") ?: Role::create(["id"=>"hfs_revoke","label"=>"HFS Revoke"]);
  $r->grantPermission("use hotkeys for save");
  $r->save();
' >/dev/null 2>&1
echo "reset: role hfs_revoke present WITH 'use hotkeys for save'"
