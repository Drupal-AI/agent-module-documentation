#!/usr/bin/env bash
# Execution RESET: set login_destination to the shipped default /user/%user/edit so verify FAILS
# until the agent changes it to /user/%user. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("login_destination", "/user/%user/edit")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: prlp.settings login_destination=/user/%user/edit"
