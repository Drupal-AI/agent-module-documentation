#!/usr/bin/env bash
# Introspection SETUP: set a known secure base URL so an inspecting agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("securelogin.settings")->set("base_url","https://secure.securelogin-probe.example")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: securelogin.settings base_url=https://secure.securelogin-probe.example"
