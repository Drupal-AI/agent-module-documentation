#!/usr/bin/env bash
# Execution RESET: put NG Lightbox back to a state where colorbox_load is NOT in use --
# no path patterns and the core modal renderer -- so the verify below fails on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "")
    ->set("renderer", "drupal_modal")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ng_lightbox.settings patterns='' renderer=drupal_modal"
