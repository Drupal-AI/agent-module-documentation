#!/usr/bin/env bash
# Execution CLEANUP: delete the vjs_task view (leave the site clean).
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vjs_task")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vjs_task removed"
