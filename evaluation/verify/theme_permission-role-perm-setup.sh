#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role tp_viewer and grant it the theme_permission dynamic
# permission to administer ONLY the olivero theme, so an inspecting agent can read back which theme
# that role may manage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tp_viewer") ?: Role::create(["id" => "tp_viewer", "label" => "TP Viewer"]);
  $r->grantPermission("administer themes olivero");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role tp_viewer granted 'administer themes olivero'"
