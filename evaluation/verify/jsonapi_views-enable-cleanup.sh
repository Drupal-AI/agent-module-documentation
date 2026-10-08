#!/usr/bin/env bash
# Execution CLEANUP: delete jav_task2. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("jav_task2")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jav_task2 removed"
