#!/usr/bin/env bash
# Introspection SETUP (health_check_url): set a known endpoint path + string + type so an agent
# can read the live health_check_url.settings config. Config-only (no router rebuild). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("health_check_url.settings")
    ->set("type", "string")->set("string", "HealthyHCU")
    ->set("endpoint", "/hcu-status")->set("maintainence_access", FALSE)->save();
' >/dev/null 2>&1 || true
echo "setup: health_check_url.settings endpoint=/hcu-status string=HealthyHCU type=string"
exit 0
