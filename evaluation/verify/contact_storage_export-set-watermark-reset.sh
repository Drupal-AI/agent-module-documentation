#!/usr/bin/env bash
# Execution RESET/CLEANUP: clear the cse_feedback watermark so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("contact_storage_export.cse_feedback")->delete("last_id");' >/dev/null 2>&1
echo "reset: contact_storage_export.cse_feedback last_id cleared"
