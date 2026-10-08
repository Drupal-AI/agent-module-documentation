#!/usr/bin/env bash
# Execution RESET: delete ga4_google_analytics.config so there is no Measurement ID configured
# (verify must FAIL until the agent sets it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ga4_google_analytics.config")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ga4_google_analytics.config deleted (no measurement id)"
