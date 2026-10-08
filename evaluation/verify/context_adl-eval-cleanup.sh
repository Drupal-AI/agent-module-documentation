#!/usr/bin/env bash
# CLEANUP (shared): delete the cadl_eval Context. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\context\Entity\Context; if ($e = Context::load("cadl_eval")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: context cadl_eval removed"
