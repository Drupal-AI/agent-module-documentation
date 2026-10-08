#!/usr/bin/env bash
# Execution CLEANUP: delete the vbpefd_task View. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if($v=View::load("vbpefd_task")){$v->delete();}' >/dev/null 2>&1
echo "cleanup: vbpefd_task removed"
