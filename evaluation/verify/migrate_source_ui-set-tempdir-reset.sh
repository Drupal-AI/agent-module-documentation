#!/usr/bin/env bash
# Execution RESET: clear file_temp_directory so verify FAILS until the agent sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_source_ui.settings")->clear("file_temp_directory")->save();' >/dev/null 2>&1
echo "reset: file_temp_directory cleared"
