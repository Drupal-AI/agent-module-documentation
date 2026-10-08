#!/usr/bin/env bash
# Introspection SETUP: enable local download+sync (download_assets=TRUE) on the DAM Image media
# type source configuration so an agent can read whether it downloads locally. Local config
# only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("acquia_dam_image_asset");
  $c = $t->get("source_configuration"); $c["download_assets"] = TRUE;
  $t->set("source_configuration", $c)->save();
' >/dev/null 2>&1
echo "setup: acquia_dam_image_asset source_configuration.download_assets=TRUE"
