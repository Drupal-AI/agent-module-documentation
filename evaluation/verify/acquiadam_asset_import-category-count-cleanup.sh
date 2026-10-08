#!/usr/bin/env bash
# Introspection CLEANUP: restore categories to shipped default {}.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquiadam_asset_import.settings")->set("categories", [])->save();' >/dev/null 2>&1
echo "cleanup: categories={}"
