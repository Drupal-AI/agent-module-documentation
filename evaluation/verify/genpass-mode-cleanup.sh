#!/usr/bin/env bash
# Restore genpass_mode to its install default (2 = restricted).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("genpass.settings")->set("genpass_mode", 2)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: genpass_mode restored to 2"
