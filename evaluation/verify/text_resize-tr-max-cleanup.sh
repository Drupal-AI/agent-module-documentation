#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default maximum (25).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("text_resize.settings")->set("text_resize_maximum",25)->save();' >/dev/null 2>&1
echo "cleanup: text_resize_maximum restored to 25"
