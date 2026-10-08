#!/usr/bin/env bash
# Introspection CLEANUP: delete the tp_viewer role created by setup. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("tp_viewer")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role tp_viewer removed"
