#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped global default resolution_type.default.default=inline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("conflict.settings")->set("resolution_type.default.default","inline")->save();' >/dev/null 2>&1
echo "cleanup: conflict.settings resolution_type.default.default=inline (default restored)"
