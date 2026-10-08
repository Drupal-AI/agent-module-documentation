#!/usr/bin/env bash
# Introspection CLEANUP: clear the recorded last_id for cse_feedback.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("contact_storage_export.cse_feedback")->delete("last_id");' >/dev/null 2>&1
echo "cleanup: contact_storage_export.cse_feedback last_id cleared"
