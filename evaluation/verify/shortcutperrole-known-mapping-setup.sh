#!/usr/bin/env bash
# Introspection SETUP (shortcutperrole): assign a known shortcut set id to the content_editor
# role in shortcutperrole.settings so an inspecting agent can read it back. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shortcutperrole.settings")
    ->set("role.content_editor", "spr_editors")->save();
' >/dev/null 2>&1 || true
echo "setup: shortcutperrole.settings role.content_editor=spr_editors"
exit 0
