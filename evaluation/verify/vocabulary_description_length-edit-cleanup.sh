#!/usr/bin/env bash
# Execution CLEANUP: delete vdl_edit. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_edit")->delete();' >/dev/null 2>&1
echo "cleanup: vdl_edit removed"
