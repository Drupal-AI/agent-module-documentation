#!/usr/bin/env bash
# Introspection SETUP: configure TWO Widen categories for bulk import so an agent can count them.
# Local config only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("acquiadam_asset_import.settings")->set("categories", [
    "cat-uuid-eval-aa" => ["acquia_dam_image_asset"],
    "cat-uuid-eval-bb" => ["acquia_dam_video_asset"],
  ])->save();
' >/dev/null 2>&1
echo "setup: 2 categories configured"
