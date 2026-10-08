#!/usr/bin/env bash
# Introspection SETUP: enable content-state autosave (h5p_save_content_state=1). Default 0. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("h5p.settings")->set("h5p_save_content_state",1)->save();' >/dev/null 2>&1
echo "setup: h5p.settings h5p_save_content_state=1"
