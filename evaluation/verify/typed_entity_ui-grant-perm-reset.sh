#!/usr/bin/env bash
# Execution RESET: enable typed_entity_ui (so the permission exists) and (re)create the role
# te_ui_role WITHOUT the 'explore typed entity classes' permission, so verify FAILS until the
# agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en typed_entity_ui -y >/dev/null 2>&1
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("te_ui_role")) { $r->delete(); }
  Role::create(["id" => "te_ui_role", "label" => "TE UI Probe Role"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typed_entity_ui enabled; role te_ui_role exists without the explore permission"
