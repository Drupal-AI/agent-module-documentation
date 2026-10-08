#!/usr/bin/env bash
# Execution RESET: set kill_switch=false and media_bundles={} so verify FAILS until the agent
# turns the kill switch on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_alias_display.settings")->set("kill_switch", FALSE)->set("media_bundles", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: kill_switch=false"
