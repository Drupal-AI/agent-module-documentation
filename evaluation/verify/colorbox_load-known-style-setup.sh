#!/usr/bin/env bash
# Introspection SETUP: give the Colorbox lightbox a known custom class / width / admin-path
# behaviour in ng_lightbox.settings so an agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("lightbox_class", "cbl-eval-overlay")
    ->set("default_width", 845)
    ->set("skip_admin_paths", FALSE)
    ->set("renderer", "drupal_colorbox")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: lightbox_class=cbl-eval-overlay default_width=845 skip_admin_paths=false"
