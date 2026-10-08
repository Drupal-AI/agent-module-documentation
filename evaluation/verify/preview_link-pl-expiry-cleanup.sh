#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default expiry (604800 seconds).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("preview_link.settings")->set("expiry_seconds",604800)->save();' >/dev/null 2>&1
echo "cleanup: expiry_seconds restored to 604800"
