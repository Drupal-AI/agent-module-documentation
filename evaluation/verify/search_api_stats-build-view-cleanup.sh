#!/usr/bin/env bash
# Execution CLEANUP: remove the sas_report View. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("sas_report")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.sas_report removed"
