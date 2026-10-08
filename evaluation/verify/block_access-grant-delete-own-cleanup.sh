#!/usr/bin/env bash
# Execution CLEANUP: delete ba_delete_role. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("ba_delete_role")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role ba_delete_role removed"
