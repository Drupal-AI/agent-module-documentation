#!/usr/bin/env bash
# Execution CLEANUP: delete view vft_task2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("vft_task2")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vft_task2 removed"
