#!/usr/bin/env bash
# Introspection CLEANUP: restore admin_routes to the shipped default (false). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("administration_language_negotiation.negotiation")
    ->set("admin_routes", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: admin_routes restored to false"
