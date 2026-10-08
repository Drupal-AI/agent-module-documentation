#!/usr/bin/env bash
# Execution RESET: ensure custom_breadcrumbs entity cb_task2 does NOT exist. verify FAILS until
# the agent creates a CONTENT-ENTITY breadcrumb for node/article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs::load("cb_task2")) { $e->delete(); }' >/dev/null 2>&1
echo "reset: cb_task2 absent"
