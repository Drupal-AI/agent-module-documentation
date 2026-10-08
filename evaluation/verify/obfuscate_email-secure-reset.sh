#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure the oe_secure text format does NOT exist, so verify FAILS until
# the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("oe_secure")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: oe_secure absent"
