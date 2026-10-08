#!/usr/bin/env bash
# Execution RESET: ensure role lbcs_paster does NOT exist, so verify FAILS until the agent
# creates it with the 'copy paste sections' permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($r = \Drupal\user\Entity\Role::load("lbcs_paster")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role lbcs_paster absent"
