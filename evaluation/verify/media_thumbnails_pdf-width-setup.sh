#!/usr/bin/env bash
# Introspection SETUP: set the global media_thumbnails thumbnail width (which the PDF plugin
# uses) to a known value 321, so the agent can inspect the live config and report it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_thumbnails.settings")->set("width", 321)->save();' >/dev/null 2>&1
echo "setup: media_thumbnails.settings width = 321"
