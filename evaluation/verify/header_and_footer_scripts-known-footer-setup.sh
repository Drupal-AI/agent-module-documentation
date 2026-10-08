#!/usr/bin/env bash
# Introspection SETUP: write a distinctive <style> into the FOOTER region config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("header_and_footer_scripts.footer.settings")
    ->set("styles", "<style>.hfs-footer-marker-xyz{color:red}</style>")
    ->set("scripts", "")
    ->save();
' >/dev/null 2>&1
echo "setup: header_and_footer_scripts.footer.settings styles contains hfs-footer-marker-xyz"
