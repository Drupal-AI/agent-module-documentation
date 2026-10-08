#!/usr/bin/env bash
# Introspection CLEANUP: delete the jav_display view. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("jav_display")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jav_display removed"
