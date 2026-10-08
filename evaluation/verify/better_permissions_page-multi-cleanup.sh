#!/usr/bin/env bash
# Execution CLEANUP: delete role bpp_multi. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("bpp_multi")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role bpp_multi removed"
