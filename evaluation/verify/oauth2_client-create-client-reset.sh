#!/usr/bin/env bash
# Execution RESET: ensure the oauth2_client config entity 'o2c_eval' does NOT exist, so verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\oauth2_client\Entity\Oauth2Client; if ($e = Oauth2Client::load("o2c_eval")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: oauth2_client entity o2c_eval absent"
