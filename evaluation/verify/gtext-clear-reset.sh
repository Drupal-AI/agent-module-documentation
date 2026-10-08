#!/usr/bin/env bash
# Execution RESET: set a key so verify (passes only when the key is empty) FAILS until cleared.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gtext.settings")->set("google_api_key","AIzaSyGTEXT-to-be-removed-000")->save();' >/dev/null 2>&1
echo "reset: gtext.settings google_api_key set (must be cleared by agent)"
