#!/usr/bin/env bash
# Introspection SETUP: write sticky.settings with a distinctive top_spacing (42px) and z_index,
# so an inspecting agent can read back the configured top spacing.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sticky.settings")
    ->set("selector", ".menu--main")
    ->set("top_spacing", 42)->set("bottom_spacing", 0)
    ->set("class_name", "is-sticky")->set("wrapper_class_name", "sticky-wrapper")
    ->set("center", FALSE)->set("get_width_from", "")
    ->set("width_from_wrapper", TRUE)->set("responsive_width", FALSE)
    ->set("z_index", "1000")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sticky.settings top_spacing=42 z_index=1000"
