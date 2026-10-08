#!/usr/bin/env bash
# Execution RESET: ensure the view vjs_task does NOT exist, so verify FAILS until the agent
# builds it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if ($v = View::load("vjs_task")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vjs_task absent"
