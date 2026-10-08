#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal\system\Entity\Menu::load("admin")->unsetThirdPartySetting("domain_menu_access","access_enabled")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: access_enabled removed from menu 'admin'"
