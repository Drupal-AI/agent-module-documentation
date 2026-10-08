#!/usr/bin/env bash
# Execution CLEANUP: delete view fcl_task. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("fcl_task")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view fcl_task removed"
