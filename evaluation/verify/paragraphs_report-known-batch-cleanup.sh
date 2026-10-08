#!/usr/bin/env bash
# Introspection CLEANUP: restore the default batch size (10). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("import_rows_per_batch", 10)->save();
' >/dev/null 2>&1
echo "cleanup: import_rows_per_batch restored to 10"
