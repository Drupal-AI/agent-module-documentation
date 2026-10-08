#!/usr/bin/env bash
# Introspection CLEANUP: remove the test GA field row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->delete("google_analytics_reports_fields")->condition("gaid","gar_known_sessions")->execute();' >/dev/null 2>&1
echo "cleanup: gar_known_sessions row removed from google_analytics_reports_fields"
