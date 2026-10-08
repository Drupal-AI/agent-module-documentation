#!/usr/bin/env bash
# Introspection SETUP: give the Toastify status toast a known non-default duration (8000ms)
# so an inspecting agent can read it back from toastify.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toastify.settings")->set("status.duration", 8000)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toastify.settings status.duration=8000"
