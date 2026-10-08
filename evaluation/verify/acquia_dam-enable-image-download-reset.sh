#!/usr/bin/env bash
# Execution RESET: force download_assets=FALSE on the DAM Image media type (remote reference)
# so verify FAILS until the agent enables local download+sync. Local config only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("acquia_dam_image_asset");
  $c = $t->get("source_configuration"); $c["download_assets"] = FALSE;
  $t->set("source_configuration", $c)->save();
' >/dev/null 2>&1
echo "reset: acquia_dam_image_asset download_assets=FALSE"
