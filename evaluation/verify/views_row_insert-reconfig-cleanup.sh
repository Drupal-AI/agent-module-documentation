#!/usr/bin/env bash
# Execution CLEANUP: remove vri_reconfig_view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vri_reconfig_view")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vri_reconfig_view removed"
