#!/usr/bin/env bash
# Execution CLEANUP: remove the access_enabled flag from 'footer', back to baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal\system\Entity\Menu::load("footer")->unsetThirdPartySetting("domain_menu_access","access_enabled")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: access_enabled removed from menu 'footer'"
