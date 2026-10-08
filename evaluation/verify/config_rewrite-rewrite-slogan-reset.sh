#!/usr/bin/env bash
# HARD execution reset (also usable as cleanup): clear the system.site slogan to its empty
# baseline so the verify FAILS until the agent rewrites it to the target value.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.site")->set("slogan", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: system.site slogan cleared to baseline (empty)"
