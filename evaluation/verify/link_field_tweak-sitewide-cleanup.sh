#!/usr/bin/env bash
# Introspection CLEANUP: restore link_field_tweak.settings toggles to shipped-off baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("link_field_tweak.settings")
    ->set("widget_field_order", FALSE)
    ->set("add_another_link", FALSE)
    ->set("uri_part_required", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: link_field_tweak.settings toggles all FALSE"
