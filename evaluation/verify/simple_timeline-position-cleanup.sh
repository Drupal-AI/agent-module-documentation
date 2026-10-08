#!/usr/bin/env bash
# Execution CLEANUP: delete view st_pos. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("st_pos")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view st_pos removed"
