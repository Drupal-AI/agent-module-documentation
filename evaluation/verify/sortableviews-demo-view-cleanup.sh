#!/usr/bin/env bash
# Introspection CLEANUP: delete the sortableviews_demo view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("sortableviews_demo")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view sortableviews_demo removed"
