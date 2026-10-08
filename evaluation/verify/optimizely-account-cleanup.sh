#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline (no account ID set). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("optimizely.settings");
  $c->clear("optimizely_id")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: optimizely_id cleared"
