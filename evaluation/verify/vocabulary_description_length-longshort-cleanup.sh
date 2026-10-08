#!/usr/bin/env bash
# Introspection CLEANUP: delete vdl_long and vdl_short. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_long")->delete();
  \Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_short")->delete();
' >/dev/null 2>&1
echo "cleanup: vdl_long and vdl_short removed"
