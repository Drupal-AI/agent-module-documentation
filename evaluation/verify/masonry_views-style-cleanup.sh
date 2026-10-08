#!/usr/bin/env bash
# Execution CLEANUP: delete the task view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("masonry_views_task")) { $v->delete(); }' >/dev/null 2>&1
echo "cleanup: view masonry_views_task removed"
