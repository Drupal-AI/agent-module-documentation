#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("registration_change_host.settings")->set("workflow", "multistep")->save();' >/dev/null 2>&1
echo "cleanup: registration_change_host.settings workflow restored to multistep"
