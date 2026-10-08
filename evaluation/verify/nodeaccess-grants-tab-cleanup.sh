#!/usr/bin/env bash
# CLEANUP: restore Grants-tab availability for Article to baseline (unset). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $c->clear("grants_tab_availability.article")->save();
' >/dev/null 2>&1
echo "cleanup: grants_tab_availability.article cleared"
