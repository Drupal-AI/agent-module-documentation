#!/usr/bin/env bash
# Execution CLEANUP: restore keep_parameters to shipped default (1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pages_restriction.settings")->set("keep_parameters", 1)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: keep_parameters restored to 1"
