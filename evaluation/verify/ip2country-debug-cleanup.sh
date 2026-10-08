#!/usr/bin/env bash
# Execution CLEANUP: restore ip2country debug settings to shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("debug", FALSE)->set("test_type", 0)->set("test_country", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ip2country.settings debug restored to defaults"
