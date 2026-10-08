#!/usr/bin/env bash
# Execution CLEANUP: remove gdpr_dump.table_map. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr_dump.table_map")->delete();' >/dev/null 2>&1
echo "cleanup: gdpr_dump.table_map removed"
