#!/usr/bin/env bash
# Execution CLEANUP: restore empty distribution_id / disabled=true baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("cloudfront_purger.settings")->set("distribution_id", "")->set("disabled", true)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: distribution_id reset to empty"
