#!/usr/bin/env bash
# Execution RESET: ensure API authentication is OFF (clear enable_authentication) so verify
# FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("rest_api_authentication.settings")->clear("enable_authentication")->save();' >/dev/null 2>&1
echo "reset: enable_authentication cleared (protection off)"
