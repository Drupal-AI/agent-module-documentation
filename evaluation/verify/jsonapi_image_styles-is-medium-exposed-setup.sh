#!/usr/bin/env bash
# Introspection SETUP: expose ONLY the 'wide' image style (so 'medium' is excluded).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jsonapi_image_styles.settings")
    ->set("image_styles", ["wide" => "wide", "thumbnail" => "0", "large" => "0", "medium" => "0"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jsonapi_image_styles.settings image_styles = {wide only}"
