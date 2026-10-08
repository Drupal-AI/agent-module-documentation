#!/usr/bin/env bash
# Execution RESET: ensure Key entity azure_api_task does NOT exist, so verify FAILS until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k = Key::load("azure_api_task")) { $k->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: Key entity azure_api_task removed (absent)"
