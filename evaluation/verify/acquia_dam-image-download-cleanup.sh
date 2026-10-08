#!/usr/bin/env bash
# Introspection CLEANUP: restore download_assets=FALSE (shipped default) on DAM Image media type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("acquia_dam_image_asset");
  $c = $t->get("source_configuration"); $c["download_assets"] = FALSE;
  $t->set("source_configuration", $c)->save();
' >/dev/null 2>&1
echo "cleanup: acquia_dam_image_asset source_configuration.download_assets=FALSE"
