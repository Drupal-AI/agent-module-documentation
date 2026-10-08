#!/usr/bin/env bash
# Introspection CLEANUP: remove the gdpr_dump.table_map config (baseline: unset). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr_dump.table_map")->delete();' >/dev/null 2>&1
echo "cleanup: gdpr_dump.table_map removed"
