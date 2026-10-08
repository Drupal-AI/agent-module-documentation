#!/usr/bin/env bash
# Execution RESET: force track_drush=norm and module_deployment=false so verify FAILS until
# the agent changes them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("new_relic_rpm.settings");
  $c->set("track_drush", "norm")->set("module_deployment", FALSE)->save();
' >/dev/null 2>&1
echo "reset: track_drush=norm module_deployment=false"
