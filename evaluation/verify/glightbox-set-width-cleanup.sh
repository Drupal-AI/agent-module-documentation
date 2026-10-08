#!/usr/bin/env bash
# Execution CLEANUP: restore default width 98%.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("glightbox.settings")->set("custom.width","98%")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: glightbox.settings custom.width=98%"
