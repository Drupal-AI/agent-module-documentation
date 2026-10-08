#!/usr/bin/env bash
# Execution RESET: delete the config_log report view so verify FAILS until it is restored.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $v = \Drupal::configFactory()->getEditable("views.view.config_log");
  if (!$v->isNew()) { $v->delete(); }
' >/dev/null 2>&1
echo "reset: views.view.config_log deleted"
