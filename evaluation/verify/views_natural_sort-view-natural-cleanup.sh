#!/usr/bin/env bash
# Execution CLEANUP: delete the views_natural_sort_demo fixture view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("views_natural_sort_demo")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views_natural_sort_demo removed"
