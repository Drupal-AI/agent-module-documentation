#!/usr/bin/env bash
# Introspection SETUP: write sticky.settings with a known DOM selector (.header-wrapper) plus
# other keys, so an inspecting agent can read back which element is configured as sticky.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sticky.settings")
    ->set("selector", ".header-wrapper")
    ->set("top_spacing", 0)->set("bottom_spacing", 0)
    ->set("class_name", "is-sticky")->set("wrapper_class_name", "sticky-wrapper")
    ->set("center", FALSE)->set("get_width_from", "")
    ->set("width_from_wrapper", TRUE)->set("responsive_width", FALSE)
    ->set("z_index", "auto")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sticky.settings selector=.header-wrapper"
