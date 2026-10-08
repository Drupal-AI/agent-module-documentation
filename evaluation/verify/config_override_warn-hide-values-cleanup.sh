#!/usr/bin/env bash
# Execution CLEANUP: restore config_override_warn.settings:show_values to the shipped default
# TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_override_warn.settings")->set("show_values", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: show_values restored to TRUE"
