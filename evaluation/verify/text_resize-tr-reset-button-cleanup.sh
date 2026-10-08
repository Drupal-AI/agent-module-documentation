#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("text_resize.settings")->set("text_resize_reset_button",false)->save();' >/dev/null 2>&1
echo "cleanup: text_resize_reset_button=false"
