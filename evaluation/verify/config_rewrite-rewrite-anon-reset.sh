#!/usr/bin/env bash
# HARD execution reset (also usable as cleanup): restore user.settings anonymous name to its
# "Anonymous" baseline so the verify FAILS until the agent rewrites it to the target value.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("user.settings")->set("anonymous", "Anonymous")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: user.settings anonymous restored to baseline (Anonymous)"
