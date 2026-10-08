#!/usr/bin/env bash
# Restore the Warmer baseline: warmer.settings has no configured warmers (install default
# is `warmers: []`).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("warmer.settings")->set("warmers", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: warmer.settings warmers reset to []"
