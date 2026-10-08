#!/usr/bin/env bash
# Execution RESET: ensure the custom_breadcrumbs entity cb_task does NOT exist. verify FAILS until
# the agent creates a path breadcrumb matching /cb-task/*. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs::load("cb_task")) { $e->delete(); }' >/dev/null 2>&1
echo "reset: cb_task absent"
