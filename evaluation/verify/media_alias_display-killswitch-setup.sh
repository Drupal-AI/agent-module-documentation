#!/usr/bin/env bash
# Introspection SETUP: turn the media_alias_display kill switch ON, so an agent can read that the
# module is currently disabled site-wide. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_alias_display.settings")->set("kill_switch", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_alias_display.settings kill_switch=true"
