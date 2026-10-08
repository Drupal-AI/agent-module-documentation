#!/usr/bin/env bash
# Introspection CLEANUP: delete the o2c_known2 oauth2_client config entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\oauth2_client\Entity\Oauth2Client; if ($e = Oauth2Client::load("o2c_known2")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: oauth2_client entity o2c_known2 removed"
