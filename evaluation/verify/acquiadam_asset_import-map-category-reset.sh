#!/usr/bin/env bash
# Execution RESET: clear the categories map so verify FAILS until the agent configures it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquiadam_asset_import.settings")->set("categories", [])->save();' >/dev/null 2>&1
echo "reset: categories={}"
