#!/usr/bin/env bash
# Introspection SETUP (shortcutperrole): assign distinct set ids to administrator and
# content_editor roles. Agent must report the set configured for administrator. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shortcutperrole.settings")
    ->set("role.administrator", "spr_admin_set")
    ->set("role.content_editor", "spr_editor_set")->save();
' >/dev/null 2>&1 || true
echo "setup: role.administrator=spr_admin_set, role.content_editor=spr_editor_set"
exit 0
