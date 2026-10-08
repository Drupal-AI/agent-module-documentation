#!/usr/bin/env bash
# Introspection SETUP: set a known Mercury Editor tray width. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mercury_editor.settings"); $c->set("dialog_tray_width", 555)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mercury_editor.settings dialog_tray_width=555"
