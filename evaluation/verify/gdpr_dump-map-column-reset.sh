#!/usr/bin/env bash
# Execution RESET: clear gdpr_dump.table_map so no column is anonymized and verify FAILS until
# the agent maps one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr_dump.table_map")->delete();' >/dev/null 2>&1
echo "reset: gdpr_dump.table_map cleared"
