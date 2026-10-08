#!/usr/bin/env bash
# Execution CLEANUP: delete the lbcs_grant role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($r = \Drupal\user\Entity\Role::load("lbcs_grant")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role lbcs_grant removed"
