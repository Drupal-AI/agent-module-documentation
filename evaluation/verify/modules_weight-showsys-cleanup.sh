#!/usr/bin/env bash
# Execution CLEANUP (modules_weight): restore show_system_modules to the shipped default FALSE.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("modules_weight.settings")->set("show_system_modules", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: modules_weight.settings show_system_modules=FALSE (baseline)"
