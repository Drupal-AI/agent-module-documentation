#!/usr/bin/env bash
# Introspection SETUP: create role libraries_ui_auditor granted the 'access libraries_ui' permission,
# so an inspecting agent can find which role can view the Libraries report. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("libraries_ui_auditor") ?: Role::create(["id" => "libraries_ui_auditor", "label" => "Libraries UI auditor"]);
  $r->grantPermission("access libraries_ui")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role libraries_ui_auditor has 'access libraries_ui'"
