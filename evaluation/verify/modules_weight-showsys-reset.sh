#!/usr/bin/env bash
# Execution RESET (modules_weight): force show_system_modules OFF (shipped default), so verify
# FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("modules_weight.settings")->set("show_system_modules", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: modules_weight.settings show_system_modules=FALSE"
