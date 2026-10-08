#!/usr/bin/env bash
# Execution RESET: ensure custom token tc_task does NOT exist, so verify FAILS until created.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\token_custom\Entity\TokenCustom; if ($e = TokenCustom::load("tc_task")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: custom token tc_task removed (absent)"
