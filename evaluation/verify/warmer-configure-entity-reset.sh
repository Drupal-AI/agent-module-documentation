#!/usr/bin/env bash
# Reset Warmer to a clean baseline before a hard execution run: clear all configured
# warmers (install default is `warmers: []`) so the entity warmer has no frequency/batchSize
# override. The verify must FAIL on this empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("warmer.settings")->set("warmers", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: warmer.settings warmers cleared to []"
