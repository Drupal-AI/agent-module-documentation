#!/usr/bin/env bash
# Introspection SETUP: restrict JSON:API Image Styles to expose only thumbnail + large.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jsonapi_image_styles.settings")
    ->set("image_styles", ["thumbnail" => "thumbnail", "large" => "large", "medium" => "0", "wide" => "0"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jsonapi_image_styles.settings image_styles = {thumbnail,large}"
