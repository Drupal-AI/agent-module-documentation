#!/usr/bin/env bash
# Introspection CLEANUP: delete vdl_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_known")->delete();' >/dev/null 2>&1
echo "cleanup: vdl_known removed"
