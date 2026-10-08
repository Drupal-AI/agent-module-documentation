#!/usr/bin/env bash
# Introspection CLEANUP (modules_weight): restore baseline - modules_weight weight back to 0 and
# show_system_modules back to the shipped default FALSE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  module_set_weight("modules_weight", 0);
  \Drupal::configFactory()->getEditable("modules_weight.settings")->set("show_system_modules", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: modules_weight weight=0; show_system_modules=FALSE (baseline)"
