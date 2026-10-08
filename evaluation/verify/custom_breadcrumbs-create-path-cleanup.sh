#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs::load("cb_task")) { $e->delete(); }' >/dev/null 2>&1
echo "cleanup: cb_task removed"
