#!/usr/bin/env bash
# Introspection SETUP: set a known twitter_handle so the agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sharethis.settings")->set("twitter_handle","drupalnews")->save();' >/dev/null 2>&1
echo "setup: sharethis.settings twitter_handle=drupalnews"
