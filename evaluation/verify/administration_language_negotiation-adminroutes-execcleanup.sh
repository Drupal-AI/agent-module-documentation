#!/usr/bin/env bash
# Execution CLEANUP: restore admin_routes to shipped default (false). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("administration_language_negotiation.negotiation")
    ->set("admin_routes", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: admin_routes restored to false"
