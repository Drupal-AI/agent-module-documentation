#!/usr/bin/env bash
# hard RESET (altcha): delete the self-hosted HMAC secret key (State altcha-hmac-key) so verify
# FAILS until the agent regenerates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("altcha.secret_manager")->deleteSecretKey();' >/dev/null 2>&1
echo "reset: ALTCHA self-hosted secret key deleted"
