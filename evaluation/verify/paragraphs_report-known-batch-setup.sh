#!/usr/bin/env bash
# Introspection SETUP: set a known non-default batch size. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("import_rows_per_batch", 37)->save();
' >/dev/null 2>&1
echo "setup: paragraphs_report.settings.import_rows_per_batch = 37"
