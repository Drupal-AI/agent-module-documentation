#!/usr/bin/env bash
# Introspection CLEANUP: restore imagick.config jpeg_quality to the shipped default (75).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("imagick.config")->set("jpeg_quality", 75)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: imagick.config jpeg_quality restored to 75"
