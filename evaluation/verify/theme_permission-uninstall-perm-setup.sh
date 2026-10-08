#!/usr/bin/env bash
# Introspection SETUP: create role tp_uviewer and grant it 'uninstall themes claro'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tp_uviewer") ?: Role::create(["id" => "tp_uviewer", "label" => "TP Uninstall Viewer"]);
  $r->grantPermission("uninstall themes claro"); $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role tp_uviewer granted 'uninstall themes claro'"
