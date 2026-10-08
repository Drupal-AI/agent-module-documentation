#!/usr/bin/env bash
# Introspection SETUP: configure DXPR Builder to use the dxpr_builder_media modal browser by
# setting dxpr_builder.settings:media_browser = dxpr_builder_media_modal, so an inspecting agent
# can read back which media browser DXPR is currently using. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en dxpr_builder_media -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("dxpr_builder.settings")
    ->set("media_browser", "dxpr_builder_media_modal")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dxpr_builder.settings media_browser = dxpr_builder_media_modal"
