#!/usr/bin/env bash
# Execution CLEANUP: delete the tp_task role built during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("tp_task")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role tp_task removed"
