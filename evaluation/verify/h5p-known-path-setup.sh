#!/usr/bin/env bash
# Introspection SETUP: set h5p.settings h5p_default_path to a known value 'lessons'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("h5p.settings")->set("h5p_default_path","lessons")->save();' >/dev/null 2>&1
echo "setup: h5p.settings h5p_default_path=lessons"
