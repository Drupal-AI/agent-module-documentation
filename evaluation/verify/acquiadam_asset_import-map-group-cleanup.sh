#!/usr/bin/env bash
# Execution CLEANUP: restore asset_groups to shipped default {}.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquiadam_asset_import.settings")->set("asset_groups", [])->save();' >/dev/null 2>&1
echo "cleanup: asset_groups={}"
