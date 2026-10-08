#!/usr/bin/env bash
# Introspection SETUP: set a known Iubenda privacy policy code (and link style) in the module's
# config so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("iubenda_integration_policy_code", "9911223")
    ->set("iubenda_integration_style", "iubenda-black")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: iubenda_integration.settings iubenda_integration_policy_code=9911223 style=iubenda-black"
