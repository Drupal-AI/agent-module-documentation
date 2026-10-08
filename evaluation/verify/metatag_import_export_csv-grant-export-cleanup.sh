#!/usr/bin/env bash
# Execution CLEANUP: delete role mie_role2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("mie_role2")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role mie_role2 removed"
