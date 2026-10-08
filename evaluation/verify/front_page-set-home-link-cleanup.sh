#!/usr/bin/env bash
# Execution RESET: clear front_page home_link_path so verify FAILS until the agent sets it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("front_page.settings")->clear("home_link_path")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: front_page.settings.home_link_path cleared"
