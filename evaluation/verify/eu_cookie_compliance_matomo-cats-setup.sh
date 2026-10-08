#!/usr/bin/env bash
# Introspection SETUP: require two cookie categories for Matomo consent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("eu_cookie_compliance_matomo.settings")
    ->set("categories", ["statistics", "marketing"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: categories=[statistics,marketing]"
