#!/usr/bin/env bash
# Introspection SETUP: enable domain_menu_access on the 'main' menu (third-party setting) so an
# agent can read back which menu is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal\system\Entity\Menu::load("main")->setThirdPartySetting("domain_menu_access","access_enabled",TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: domain_menu_access access_enabled=true on menu 'main'"
