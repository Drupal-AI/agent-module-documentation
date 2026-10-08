#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default hasher. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hacked.settings")->set("selected_file_hasher", "hacked_ignore_line_endings")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: hacked.settings selected_file_hasher = hacked_ignore_line_endings (default)"
