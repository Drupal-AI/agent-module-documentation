#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults for the slow-view keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("new_relic_rpm.settings");
  $c->set("views_log_slow", FALSE)->set("views_log_threshold", 100)->save();
' >/dev/null 2>&1
echo "cleanup: slow-view keys restored (false / 100)"
