#!/usr/bin/env bash
# Execution RESET: clear the allowed-domains list (and ensure noreferrer=TRUE), so verify FAILS
# until the agent allowlists the target domain. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noreferrer.settings")
    ->set("allowed_domains", [])
    ->set("noreferrer", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: noreferrer.settings allowed_domains = [] (trusted-partner.example not allowed)"
