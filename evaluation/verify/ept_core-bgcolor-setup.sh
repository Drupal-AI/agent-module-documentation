#!/usr/bin/env bash
# Introspection SETUP: set the EPT global background color to a known value so an agent can read
# it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ept_core.settings")->set("ept_core_background_color", "#123456")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ept_core.settings ept_core_background_color = #123456"
