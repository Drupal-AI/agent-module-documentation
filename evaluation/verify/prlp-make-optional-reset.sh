#!/usr/bin/env bash
# Execution RESET: set password_required=true (shipped default) so verify FAILS until the agent
# makes the new-password field optional. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("password_required", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: prlp.settings password_required=true"
