#!/usr/bin/env bash
# Execution RESET: set the global default resolution strategy resolution_type.default.default to
# inline (shipped default), so verify FAILS until the agent changes the site-wide default to dialog. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("conflict.settings")->set("resolution_type.default.default","inline")->save();' >/dev/null 2>&1
echo "reset: conflict.settings resolution_type.default.default=inline"
