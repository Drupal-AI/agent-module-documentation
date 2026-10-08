#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal\system\Entity\Menu::load("account")->setThirdPartySetting("domain_menu_access","access_enabled",TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: access_enabled=true on menu 'account'"
