#!/usr/bin/env bash
# Introspection SETUP: set a known preview link expiry (in seconds) on the live site.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("preview_link.settings")->set("expiry_seconds",3600)->save();' >/dev/null 2>&1
echo "setup: preview_link.settings expiry_seconds=3600"
