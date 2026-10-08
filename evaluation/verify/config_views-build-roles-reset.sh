#!/usr/bin/env bash
# reset: View cv_roles absent
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("cv_roles")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: View cv_roles absent"
