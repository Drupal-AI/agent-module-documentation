#!/usr/bin/env bash
# Introspection SETUP: set the icon_select sprite path to a distinctive value so the agent can
# read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("icon_select.settings")->set("path", "icons/is_probe_map.svg")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: icon_select.settings path=icons/is_probe_map.svg"
