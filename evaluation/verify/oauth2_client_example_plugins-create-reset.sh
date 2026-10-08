#!/usr/bin/env bash
# Execution RESET: ensure oauth2_client config entity 'o2cex_eval' does NOT exist. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\oauth2_client\Entity\Oauth2Client; if ($e = Oauth2Client::load("o2cex_eval")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: o2cex_eval absent"
