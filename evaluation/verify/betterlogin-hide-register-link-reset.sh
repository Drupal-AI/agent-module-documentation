#!/usr/bin/env bash
# Execution RESET: set register=visitors so the register link is SHOWN and verify FAILS until the
# agent restricts registration to admins. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user.settings")->set("register", "visitors")->save();' >/dev/null 2>&1
echo "reset: user.settings register=visitors (register link shown)"
