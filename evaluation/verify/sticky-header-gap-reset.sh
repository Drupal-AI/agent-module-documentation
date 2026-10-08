#!/usr/bin/env bash
# Execution RESET: set sticky.settings with selector=.menu--main and top_spacing=0, so verify
# (wants selector=.site-header AND top_spacing=30) FAILS until the agent configures it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sticky.settings")
    ->set("selector", ".menu--main")->set("top_spacing", 0)->set("bottom_spacing", 0)
    ->set("class_name", "is-sticky")->set("wrapper_class_name", "sticky-wrapper")
    ->set("center", FALSE)->set("get_width_from", "")->set("width_from_wrapper", TRUE)
    ->set("responsive_width", FALSE)->set("z_index", "auto")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sticky.settings selector=.menu--main top_spacing=0"
