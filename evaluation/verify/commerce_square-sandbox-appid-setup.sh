#!/usr/bin/env bash
# Introspection SETUP: set a KNOWN sandbox application id on commerce_square.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_square.settings")->set("sandbox_app_id", "sandbox-sq0idb-KNOWN123")->save();' >/dev/null 2>&1
echo "setup: commerce_square.settings sandbox_app_id=sandbox-sq0idb-KNOWN123"
