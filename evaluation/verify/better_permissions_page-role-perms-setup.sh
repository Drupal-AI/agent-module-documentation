#!/usr/bin/env bash
# Introspection SETUP: create role bpp_editor with exactly one distinctive core permission
# ('access site reports') so an inspecting agent can read back which permission it has.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("bpp_editor")) { Role::create(["id" => "bpp_editor", "label" => "BPP Editor"])->save(); }
  user_role_grant_permissions("bpp_editor", ["access site reports"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role bpp_editor has permission 'access site reports'"
