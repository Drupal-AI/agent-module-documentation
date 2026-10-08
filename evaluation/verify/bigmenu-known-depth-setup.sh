#!/usr/bin/env bash
# Introspection SETUP for bigmenu: set the single module setting `max_depth` to a KNOWN
# value (4) in the `bigmenu.settings` config object so the agent can read it back off the
# live site. Baseline (install default) is 1; the paired cleanup restores it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bigmenu.settings")->set("max_depth", 4)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: bigmenu.settings max_depth = 4"
