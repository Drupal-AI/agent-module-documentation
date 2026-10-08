#!/usr/bin/env bash
# Introspection SETUP: create role ba_known_editor granted the block_access permission
# 'update own basic block_content', so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ba_known_editor") ?: Role::create(["id" => "ba_known_editor", "label" => "BA Known Editor"]);
  $r->grantPermission("update own basic block_content");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role ba_known_editor has 'update own basic block_content'"
