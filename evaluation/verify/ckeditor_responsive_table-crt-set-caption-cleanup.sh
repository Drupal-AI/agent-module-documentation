#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ckeditor_responsive_table.settings")->clear("caption_side")->save();' >/dev/null 2>&1
echo "cleanup: caption_side cleared"
