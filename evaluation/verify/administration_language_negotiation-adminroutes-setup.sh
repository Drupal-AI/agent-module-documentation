#!/usr/bin/env bash
# Introspection SETUP: turn ON the admin_routes setting in the module config, so an agent can
# inspect administration_language_negotiation.negotiation and report the boolean. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("administration_language_negotiation.negotiation")
    ->set("admin_routes", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: admin_routes = true"
