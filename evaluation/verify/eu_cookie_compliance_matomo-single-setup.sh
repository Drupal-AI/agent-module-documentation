#!/usr/bin/env bash
# Introspection SETUP: a single distinct category required for Matomo consent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("eu_cookie_compliance_matomo.settings")
    ->set("categories", ["ecc_social_media"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: categories=[ecc_social_media]"
