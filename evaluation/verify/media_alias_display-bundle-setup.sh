#!/usr/bin/env bash
# Introspection SETUP: restrict media_alias_display to the 'document' media bundle only, so an
# agent can read which bundles are allowed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_alias_display.settings")->set("media_bundles", ["document" => "document"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_alias_display.settings media_bundles={document}"
