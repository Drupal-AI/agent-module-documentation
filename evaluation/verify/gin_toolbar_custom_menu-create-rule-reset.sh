#!/usr/bin/env bash
# Execution RESET: delete gin_toolbar_custom_menu.settings so there is NO rule, so verify FAILS
# until the agent creates a rule mapping the 'main' menu to the authenticated role.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_toolbar_custom_menu.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gin_toolbar_custom_menu.settings absent (no rules)"
