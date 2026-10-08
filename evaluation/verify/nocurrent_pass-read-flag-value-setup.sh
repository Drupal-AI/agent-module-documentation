#!/usr/bin/env bash
# Introspection SETUP: set a known value (disabled=TRUE) so the agent can read back the key/value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("nocurrent_pass.settings")->set("nocurrent_pass_disabled", TRUE)->save();' >/dev/null 2>&1
echo "nocurrent_pass.settings:nocurrent_pass_disabled set to TRUE"
