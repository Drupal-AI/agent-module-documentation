#!/usr/bin/env bash
# Execution CLEANUP: clear allowed_image_styles back to [] (shipped default: unset/no restriction).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("acquia_dam.settings")->clear("allowed_image_styles")->save();' >/dev/null 2>&1
echo "cleanup: acquia_dam.settings allowed_image_styles=[]"
