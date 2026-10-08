#!/usr/bin/env bash
# Execution RESET: set Webp fallback quality to the default 75 so verify FAILS until the agent sets
# it to 60. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("wpf.settings")->set("quality", 75)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: wpf.settings quality=75 (default)"
