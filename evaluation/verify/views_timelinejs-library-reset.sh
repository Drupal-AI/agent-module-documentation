#!/usr/bin/env bash
# Execution RESET: force the library location to 'cdn' so verify FAILS until the agent pins it to
# version 3.9.7 (cdn_3.9.7). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("views_timelinejs.settings")->set("library_location", "cdn")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views_timelinejs.settings:library_location = cdn"
