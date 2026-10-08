#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("ren_task_view")) $v->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view ren_task_view removed"
