#!/usr/bin/env bash
# Execution RESET: ensure the 'cadl_hard' Context does NOT exist so verify FAILS until built. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\context\Entity\Context; if ($e = Context::load("cadl_hard")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: context cadl_hard removed"
