#!/usr/bin/env bash
# Execution RESET: force keep_parameters OFF (0) so verify FAILs until the agent enables it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pages_restriction.settings")->set("keep_parameters", 0)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: keep_parameters = 0"
