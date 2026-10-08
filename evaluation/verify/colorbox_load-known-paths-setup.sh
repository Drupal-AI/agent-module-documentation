#!/usr/bin/env bash
# Introspection SETUP: write a known NG Lightbox configuration (the config object that
# colorbox_load's `configure` route points at) so an agent can read back which paths are
# lightboxed and which renderer is active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "/cbl-demo/*\n/cbl-demo-two")
    ->set("renderer", "drupal_colorbox")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ng_lightbox.settings patterns=/cbl-demo/*,/cbl-demo-two renderer=drupal_colorbox"
