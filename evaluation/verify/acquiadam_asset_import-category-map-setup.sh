#!/usr/bin/env bash
# Introspection SETUP: map a known Widen category UUID to the Image media type in
# acquiadam_asset_import.settings so an agent can read the mapping. Local config only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquiadam_asset_import.settings")->set("categories", ["cat-uuid-eval-001" => ["acquia_dam_image_asset"]])->save();' >/dev/null 2>&1
echo "setup: categories={cat-uuid-eval-001:[acquia_dam_image_asset]}"
