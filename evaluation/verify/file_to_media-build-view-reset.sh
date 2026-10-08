#!/usr/bin/env bash
# Execution RESET: ensure view ftm_files does NOT exist, so verify FAILS until the agent
# builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("ftm_files")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view ftm_files absent"
