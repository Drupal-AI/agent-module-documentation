#!/usr/bin/env bash
# Execution RESET: ensure currency QHC does NOT exist, so verify FAILS until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\currency\Entity\Currency; if ($c = Currency::load("QHC")) { $c->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: currency QHC absent"
