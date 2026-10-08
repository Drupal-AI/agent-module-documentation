#!/usr/bin/env bash
# Execution CLEANUP: delete the vsmf_task view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vsmf_task")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vsmf_task removed"
