#!/usr/bin/env bash
# Execution RESET: force registration mode to the shipped default 'with-pass' so verify FAILS until
# the agent switches it to 'none'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_registrationpassword.settings")->set("registration","with-pass")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: registration=with-pass"
