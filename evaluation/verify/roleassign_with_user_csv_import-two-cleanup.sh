#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("roleassign.settings")->set("roleassign_roles", [])->save();' >/dev/null 2>&1
echo "cleanup: roleassign_roles reset to empty"
