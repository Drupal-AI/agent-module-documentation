#!/usr/bin/env bash
# Introspection SETUP: exclude the administrator role from Crazy Egg tracking. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("crazyegg.settings")->set("crazyegg_roles_excluded",["administrator"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: crazyegg.settings crazyegg_roles_excluded=[administrator]"
