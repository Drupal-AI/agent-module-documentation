#!/usr/bin/env bash
# Introspection SETUP: enable the site-wide 'Add another link' relabel in link_field_tweak.settings
# (and leave the other two toggles off), so an inspecting agent can read the live config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("link_field_tweak.settings")
    ->set("widget_field_order", FALSE)
    ->set("add_another_link", TRUE)
    ->set("uri_part_required", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: link_field_tweak.settings add_another_link=TRUE (others FALSE)"
