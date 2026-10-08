#!/usr/bin/env bash
# Execution RESET: force the global thumbnail width to the shipped default (500) so verify FAILS
# until the agent changes it to 250. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_thumbnails.settings")->set("width", 500)->save();' >/dev/null 2>&1
echo "reset: media_thumbnails.settings width = 500"
