#!/usr/bin/env bash
# CLEANUP/RESET-teardown: delete the views_parity_row_demo fixture view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("views_parity_row_demo")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views_parity_row_demo removed"
