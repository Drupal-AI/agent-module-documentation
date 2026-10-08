#!/usr/bin/env bash
# Restore genpass_length to its install default (12).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("genpass.settings")->set("genpass_length", 12)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: genpass_length restored to 12"
