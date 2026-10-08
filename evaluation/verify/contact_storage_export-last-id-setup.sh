#!/usr/bin/env bash
# Introspection SETUP: record last exported id = 7 for cse_feedback in the key/value store.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("contact_storage_export.cse_feedback")->set("last_id", 7);' >/dev/null 2>&1
echo "setup: contact_storage_export.cse_feedback last_id=7"
