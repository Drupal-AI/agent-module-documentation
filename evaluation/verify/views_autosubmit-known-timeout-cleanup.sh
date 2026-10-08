#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("va_known")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view va_known removed"
