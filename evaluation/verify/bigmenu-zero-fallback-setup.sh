#!/usr/bin/env bash
# Introspection SETUP for bigmenu: set `max_depth` to 0. BigMenuForm reads it as
# `$config->get("max_depth") ?: 1`, so a stored 0 falls back to an effective depth of 1.
# The agent must read the live config (0) AND know the fallback to answer the EFFECTIVE depth.
# Baseline is 1; the paired cleanup restores it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bigmenu.settings")->set("max_depth", 0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: bigmenu.settings max_depth = 0 (effective depth falls back to 1)"
