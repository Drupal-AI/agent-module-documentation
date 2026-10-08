#!/usr/bin/env bash
# Execution RESET: ensure the 'footer' menu does NOT have domain_menu_access enabled, so verify
# FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal\system\Entity\Menu::load("footer")->unsetThirdPartySetting("domain_menu_access","access_enabled")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'footer' menu has no domain_menu_access flag"
