#!/usr/bin/env bash
# Introspection CLEANUP: delete ga4_google_analytics.config to restore the shipped baseline
# (the module ships no config/install default, so the object should not exist). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ga4_google_analytics.config")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ga4_google_analytics.config deleted"
