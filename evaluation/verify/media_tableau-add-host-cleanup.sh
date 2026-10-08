#!/usr/bin/env bash
# Execution CLEANUP: restore media_tableau allowed_hosts to the shipped default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_tableau.settings")
    ->set("allowed_hosts", ["https://public.tableau.com"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media_tableau.settings allowed_hosts restored to [public.tableau.com]"
