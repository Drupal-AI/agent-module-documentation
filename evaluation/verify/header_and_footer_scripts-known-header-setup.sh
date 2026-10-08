#!/usr/bin/env bash
# Introspection SETUP: write a distinctive inline script into the HEADER region config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("header_and_footer_scripts.header.settings")
    ->set("scripts", "<script>console.log(\"HFS_MARKER_ABC123\");</script>")
    ->set("styles", "")
    ->save();
' >/dev/null 2>&1
echo "setup: header_and_footer_scripts.header.settings scripts contains HFS_MARKER_ABC123"
