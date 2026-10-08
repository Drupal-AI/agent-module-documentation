#!/usr/bin/env bash
# Execution RESET: clear page_specific_class mapping so verify FAILS until the agent adds it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("page_specific_class.settings")->set("url_with_class", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: page_specific_class.settings url_with_class='' (empty)"
