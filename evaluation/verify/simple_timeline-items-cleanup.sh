#!/usr/bin/env bash
# Introspection CLEANUP: delete view st_demo. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\views\Entity\View::load("st_demo")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view st_demo removed"
