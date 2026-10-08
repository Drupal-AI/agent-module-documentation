#!/usr/bin/env bash
# Execution RESET: force link_field_tweak.settings add_another_link OFF, so verify FAILS until the
# agent enables the site-wide 'Add another link' relabel. Idempotent. Exit 0.
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
echo "reset: link_field_tweak.settings add_another_link=FALSE"
