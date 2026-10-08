#!/usr/bin/env bash
# Execution RESET: set dxpr_builder.settings:media_browser to '' (basic file upload), so verify
# FAILS until the agent configures DXPR to use the dxpr_builder_media browser. Ensures the
# submodule is enabled so the browser is available. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en dxpr_builder_media -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("dxpr_builder.settings")
    ->set("media_browser", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: dxpr_builder.settings media_browser = '' (not the DXPR media browser)"
