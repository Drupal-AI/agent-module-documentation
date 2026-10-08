#!/usr/bin/env bash
# Introspection SETUP: set the image overlay minimum dimension to a known value (300) and enable
# the transparent-gif image option, so an inspecting agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("copyprevention.settings")
    ->set("copyprevention_images", ["contextmenu" => 0, "transparentgif" => "transparentgif"])
    ->set("copyprevention_images_min_dimension", 300)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: copyprevention_images_min_dimension=300, transparentgif on"
