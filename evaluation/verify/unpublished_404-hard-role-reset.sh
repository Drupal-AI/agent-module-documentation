#!/usr/bin/env bash
# Execution RESET: ensure role u404_viewer does NOT exist, so verify FAILS until the agent creates it
# with the 'view own unpublished content' permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("u404_viewer")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role u404_viewer absent"
