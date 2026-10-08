#!/usr/bin/env bash
# Introspection SETUP: set a known file_temp_directory in migrate_source_ui.settings so an
# agent can read where uploaded source files are stored. Local config only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_source_ui.settings")->set("file_temp_directory", "private://migrate_source_ui_eval")->save();' >/dev/null 2>&1
echo "setup: migrate_source_ui.settings file_temp_directory=private://migrate_source_ui_eval"
