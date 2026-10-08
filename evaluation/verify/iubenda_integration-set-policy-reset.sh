#!/usr/bin/env bash
# Execution RESET: clear the Iubenda privacy policy code so verify FAILS until the agent sets it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("iubenda_integration_policy_code", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: iubenda_integration.settings iubenda_integration_policy_code = '' (empty)"
