#!/usr/bin/env bash
# Introspection CLEANUP: delete the vrd_intro view.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vrd_intro")->delete();' >/dev/null 2>&1
echo "cleanup: view vrd_intro deleted"
