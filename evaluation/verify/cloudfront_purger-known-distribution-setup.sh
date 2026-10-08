#!/usr/bin/env bash
# Introspection SETUP: set cloudfront_purger distribution_id to a known value (keep disabled=true;
# no AWS calls). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cloudfront_purger.settings")
    ->set("distribution_id", "E1MYDISTABC123")->set("disabled", true)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: distribution_id=E1MYDISTABC123 (disabled=true)"
