#!/usr/bin/env bash
# Introspection CLEANUP: restore ng_lightbox.settings to the values the module ships in
# config/install (patterns '', width 700, class '', skip_admin_paths TRUE, renderer drupal_modal).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "")
    ->set("default_width", 700)
    ->set("lightbox_class", "")
    ->set("skip_admin_paths", TRUE)
    ->set("renderer", "drupal_modal")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ng_lightbox.settings restored to shipped defaults"
exit 0
