#!/usr/bin/env bash
# Execution RESET: force ip2country debug/spoofing OFF and clear test_country (shipped defaults)
# so verify FAILS until the agent enables spoofing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ip2country.settings");
  $c->set("debug", FALSE)->set("test_type", 0)->set("test_country", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ip2country.settings debug=false test_type=0 test_country=''"
