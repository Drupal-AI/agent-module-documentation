#!/usr/bin/env bash
# Introspection SETUP: enable the optional Display Suite alternate layout suggestions flag.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("twigsuggest.settings")->set("alternate_ds_suggestions", TRUE)->save();' >/dev/null 2>&1
echo "setup: twigsuggest.settings alternate_ds_suggestions=true"
