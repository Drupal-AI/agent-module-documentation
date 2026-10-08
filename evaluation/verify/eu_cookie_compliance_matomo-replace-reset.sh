#!/usr/bin/env bash
# Execution RESET: seed a stale category so verify FAILS until the agent replaces it with analytics.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("eu_cookie_compliance_matomo.settings")
    ->set("categories", ["legacy_cat"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: categories=[legacy_cat]"
