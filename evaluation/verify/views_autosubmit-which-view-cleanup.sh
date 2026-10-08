#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; foreach (["va_auto","va_basic"] as $id) { if ($v = View::load($id)) { $v->delete(); } }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: va_auto / va_basic removed"
