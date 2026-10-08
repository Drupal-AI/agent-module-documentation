#!/usr/bin/env bash
# Introspection CLEANUP: remove the gdpr.content_mapping config (baseline: unset). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gdpr.content_mapping")->delete();
' >/dev/null 2>&1
echo "cleanup: gdpr.content_mapping removed (baseline)"
