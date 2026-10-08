#!/usr/bin/env bash
# Execution RESET: set media_bundles={} (all) and kill_switch=false so verify FAILS until the
# agent restricts the module to the 'document' bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_alias_display.settings")->set("media_bundles", [])->set("kill_switch", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media_bundles={} (all bundles)"
