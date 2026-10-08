#!/usr/bin/env bash
# Execution CLEANUP (field): delete view vab_fview. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("vab_fview")) $v->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vab_fview removed"
