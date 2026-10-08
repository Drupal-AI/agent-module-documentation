#!/usr/bin/env bash
# Restore baseline: empty allow-list (expose all styles = shipped default behaviour).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jsonapi_image_styles.settings")->set("image_styles", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jsonapi_image_styles.settings image_styles reset to [] (all exposed)"
