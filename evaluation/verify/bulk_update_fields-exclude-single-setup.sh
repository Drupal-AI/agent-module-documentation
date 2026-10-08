#!/usr/bin/env bash
# Introspection SETUP: exclude exactly one known field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bulk_update_fields.settings")
    ->set("exclude", ["field_buf_probe_only"])->save();
' >/dev/null 2>&1
echo "setup: bulk_update_fields.settings exclude = [field_buf_probe_only]"
