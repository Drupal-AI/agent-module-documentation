#!/usr/bin/env bash
# Execution CLEANUP: delete role u404_viewer.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("u404_viewer")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role u404_viewer removed"
