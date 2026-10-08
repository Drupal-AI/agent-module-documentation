#!/usr/bin/env bash
# Introspection SETUP: set the Hacked! file hasher to 'include line endings' so an agent can
# read back which hasher is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hacked.settings")->set("selected_file_hasher", "hacked_include_line_endings")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: hacked.settings selected_file_hasher = hacked_include_line_endings"
