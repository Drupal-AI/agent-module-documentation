#!/usr/bin/env bash
# Introspection CLEANUP: remove file_temp_directory (baseline: unset = Drupal temporary scheme).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_source_ui.settings")->clear("file_temp_directory")->save();' >/dev/null 2>&1
echo "cleanup: file_temp_directory cleared"
