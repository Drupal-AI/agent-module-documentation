#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default (empty policy code). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("iubenda_integration_policy_code", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: iubenda_integration.settings iubenda_integration_policy_code restored to ''"
