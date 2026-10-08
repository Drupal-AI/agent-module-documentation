#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults track_drush=norm, module_deployment=false.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("new_relic_rpm.settings");
  $c->set("track_drush", "norm")->set("module_deployment", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: track_drush=norm module_deployment=false"
