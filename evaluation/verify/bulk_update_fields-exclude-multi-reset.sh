#!/usr/bin/env bash
# Execution RESET: clear the exclude list so verify FAILS until the agent excludes both fields.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bulk_update_fields.settings")
    ->set("exclude", [])->save();
' >/dev/null 2>&1
echo "reset: bulk_update_fields.settings exclude = []"
