#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (empty twitter_handle).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sharethis.settings")->set("twitter_handle","")->save();' >/dev/null 2>&1
echo "cleanup: sharethis.settings twitter_handle restored to ''"
