#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline. On this site rate.settings does not exist until the
# settings form is saved, so the setup-created object is deleted entirely. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("rate.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rate.settings removed (baseline: config absent)"
