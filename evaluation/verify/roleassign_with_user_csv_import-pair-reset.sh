#!/usr/bin/env bash
# Execution RESET/CLEANUP: clear delegated roles so verify FAILS until configured. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("roleassign.settings")->set("roleassign_roles", [])->save();' >/dev/null 2>&1
echo "reset: roleassign_roles empty"
