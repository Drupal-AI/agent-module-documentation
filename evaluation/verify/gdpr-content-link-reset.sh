#!/usr/bin/env bash
# Execution RESET: clear the gdpr.content_mapping config so no privacy policy link is set and
# verify FAILS until the agent configures one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gdpr.content_mapping")->delete();
' >/dev/null 2>&1
echo "reset: gdpr.content_mapping cleared (no privacy policy link)"
