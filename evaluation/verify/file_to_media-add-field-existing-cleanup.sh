#!/usr/bin/env bash
# Execution CLEANUP: delete ftm_target_view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("ftm_target_view")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view ftm_target_view removed"
