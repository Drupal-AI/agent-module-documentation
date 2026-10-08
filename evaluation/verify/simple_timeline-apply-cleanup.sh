#!/usr/bin/env bash
# Execution CLEANUP: delete view st_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("st_task")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view st_task removed"
