#!/usr/bin/env bash
# Execution CLEANUP: restore direct URL generation to shipped default (disabled).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("textimage.settings")->set("url_generation.enabled", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: textimage.settings url_generation.enabled=false (default)"
