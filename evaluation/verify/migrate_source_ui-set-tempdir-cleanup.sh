#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (clear file_temp_directory).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_source_ui.settings")->clear("file_temp_directory")->save();' >/dev/null 2>&1
echo "cleanup: file_temp_directory cleared"
