#!/usr/bin/env bash
# Introspection SETUP for bigmenu: set `max_depth` to a KNOWN value (3). The agent must read
# the live config to answer how many levels the menu edit form renders at once right now.
# Baseline is 1; the paired cleanup restores it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bigmenu.settings")->set("max_depth", 3)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: bigmenu.settings max_depth = 3"
