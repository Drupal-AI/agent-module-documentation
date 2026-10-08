#!/usr/bin/env bash
# Introspection SETUP: set a known total_request_limit (42) in quicklink.settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")->set("total_request_limit", 42)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: quicklink.settings total_request_limit=42"
