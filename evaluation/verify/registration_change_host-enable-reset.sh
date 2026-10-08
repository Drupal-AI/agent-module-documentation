#!/usr/bin/env bash
# Execution RESET: workflow=multistep (shipped default) so verify fails first.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("registration_change_host.settings")->set("workflow", "multistep")->save();' >/dev/null 2>&1
echo "reset: registration_change_host.settings workflow=multistep"
