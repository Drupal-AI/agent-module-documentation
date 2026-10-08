#!/usr/bin/env bash
# Introspection CLEANUP: restore empty distribution_id and disabled=true baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cloudfront_purger.settings")
    ->set("distribution_id", "")->set("disabled", true)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: distribution_id reset to empty (disabled=true)"
