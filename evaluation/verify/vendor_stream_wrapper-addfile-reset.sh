#!/usr/bin/env bash
# Shared RESET/CLEANUP for vendor_stream_wrapper: restore baseline by deleting the settings
# config object (the module ships no config/install, so 'no config' is the true baseline).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("vendor_stream_wrapper.settings")->delete();' >/dev/null 2>&1
echo "restore: vendor_stream_wrapper.settings deleted (baseline)"
