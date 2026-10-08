#!/usr/bin/env bash
# Introspection SETUP: set a known Hotjar ID (account) so the agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hotjar.settings")->set("account","1234567")->save();' >/dev/null 2>&1
echo "setup: hotjar.settings account=1234567"
