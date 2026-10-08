#!/usr/bin/env bash
# Execution RESET: expose ALL styles (empty allow-list) so a "thumbnail+large only" verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("jsonapi_image_styles.settings")->set("image_styles", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jsonapi_image_styles.settings image_styles = [] (all exposed)"
