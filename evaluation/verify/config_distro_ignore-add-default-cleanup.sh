#!/usr/bin/env bash
# Execution CLEANUP: restore default_collection to empty. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_ignore.settings")->set("default_collection", [])->save();' >/dev/null 2>&1
echo "cleanup: config_distro_ignore.settings default_collection restored to empty"
