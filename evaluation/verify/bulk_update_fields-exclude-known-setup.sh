#!/usr/bin/env bash
# Introspection SETUP: write a known exclude list to bulk_update_fields.settings so an inspecting
# agent can read which fields are excluded from bulk updates. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bulk_update_fields.settings")
    ->set("exclude", ["body", "field_buf_probe_a"])->save();
' >/dev/null 2>&1
echo "setup: bulk_update_fields.settings exclude = [body, field_buf_probe_a]"
