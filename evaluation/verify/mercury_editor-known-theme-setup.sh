#!/usr/bin/env bash
# Introspection SETUP: set a known Mercury Editor edit-tray theme. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mercury_editor.settings"); $c->set("edit_screen_theme", "claro")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mercury_editor.settings edit_screen_theme=claro"
