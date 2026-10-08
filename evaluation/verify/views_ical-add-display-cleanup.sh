#!/usr/bin/env bash
# Execution CLEANUP (views_ical H2): delete the vical_base view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v=View::load("vical_base")){$v->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vical_base removed"
