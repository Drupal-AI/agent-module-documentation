#!/usr/bin/env bash
# Execution RESET: force the hasher back to the default (ignore line endings) so verify FAILS
# until the agent switches it to include line endings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hacked.settings")->set("selected_file_hasher", "hacked_ignore_line_endings")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: hacked.settings selected_file_hasher = hacked_ignore_line_endings"
