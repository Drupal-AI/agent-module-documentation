#!/usr/bin/env bash
# Execution CLEANUP: delete the lbcs_paster role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($r = \Drupal\user\Entity\Role::load("lbcs_paster")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role lbcs_paster removed"
