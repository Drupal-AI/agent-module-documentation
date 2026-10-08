#!/usr/bin/env bash
# Execution CLEANUP: remove the kint.helper.kdd config created for the task. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.helper.kdd")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: kint.helper.kdd removed"
