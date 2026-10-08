#!/usr/bin/env bash
# Execution CLEANUP: remove the gdpr.content_mapping config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gdpr.content_mapping")->delete();' >/dev/null 2>&1
echo "cleanup: gdpr.content_mapping removed"
