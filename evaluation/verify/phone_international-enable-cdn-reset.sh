#!/usr/bin/env bash
# Execution RESET: set phone_international.settings.cdn = FALSE so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("phone_international.settings")->set("cdn", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: phone_international.settings.cdn = false"
