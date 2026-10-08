#!/usr/bin/env bash
# Execution RESET: delete Key ee_api_key so verify FAILS until the agent creates it encrypted at rest.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k = Key::load("ee_api_key")) { $k->delete(); }' >/dev/null 2>&1
echo "reset: Key ee_api_key removed"
