#!/usr/bin/env bash
# Execution RESET: clear the asset_groups map so verify FAILS until the agent configures it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquiadam_asset_import.settings")->set("asset_groups", [])->save();' >/dev/null 2>&1
echo "reset: asset_groups={}"
