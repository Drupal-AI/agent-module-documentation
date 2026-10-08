#!/usr/bin/env bash
# Execution RESET: clear distribution_id (verify FAILS until the agent sets E2HARDDIST999). Keeps
# disabled=true. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("cloudfront_purger.settings")->set("distribution_id", "")->set("disabled", true)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: distribution_id empty"
