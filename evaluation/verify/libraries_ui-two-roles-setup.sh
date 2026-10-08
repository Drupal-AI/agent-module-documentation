#!/usr/bin/env bash
# Introspection SETUP: create libraries_ui_allowed (WITH access libraries_ui) and libraries_ui_denied
# (WITHOUT it), so an agent must inspect config to say which one can view the report. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $a = Role::load("libraries_ui_allowed") ?: Role::create(["id" => "libraries_ui_allowed", "label" => "Libraries UI allowed"]);
  $a->grantPermission("access libraries_ui")->save();
  $d = Role::load("libraries_ui_denied") ?: Role::create(["id" => "libraries_ui_denied", "label" => "Libraries UI denied"]);
  $d->revokePermission("access libraries_ui")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: libraries_ui_allowed has access libraries_ui; libraries_ui_denied does not"
