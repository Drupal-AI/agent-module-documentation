#!/usr/bin/env bash
# Execution CLEANUP: delete view fcl_plan. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("fcl_plan")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view fcl_plan removed"
