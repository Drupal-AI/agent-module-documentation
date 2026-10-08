#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twigsuggest.settings")->set("alternate_ds_suggestions", TRUE)->save();' >/dev/null 2>&1
echo "reset: alternate_ds_suggestions=true"
