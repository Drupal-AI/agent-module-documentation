#!/usr/bin/env bash
# Introspection CLEANUP: restore shariff.settings shipped defaults explicitly. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shariff.settings")
    ->set("shariff_services", ["twitter"=>"twitter","facebook"=>"facebook"])
    ->set("shariff_theme", "colored")
    ->set("shariff_css", "complete")
    ->set("shariff_orientation", "horizontal")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: shariff.settings restored to shipped defaults"
