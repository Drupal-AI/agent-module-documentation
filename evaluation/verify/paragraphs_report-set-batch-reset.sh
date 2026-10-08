#!/usr/bin/env bash
# Execution RESET: set batch size to default 10 so verify FAILS until the agent changes it to 50.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("import_rows_per_batch", 10)->save();
' >/dev/null 2>&1
echo "reset: import_rows_per_batch = 10"
