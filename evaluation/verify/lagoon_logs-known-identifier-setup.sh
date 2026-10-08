#!/usr/bin/env bash
# Introspection SETUP: set a known leading identifier in lagoon_logs.settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'Drupal::configFactory()->getEditable("lagoon_logs.settings")->set("identifier","probe-app-x")->save();' >/dev/null 2>&1
echo "setup: lagoon_logs identifier=probe-app-x"
