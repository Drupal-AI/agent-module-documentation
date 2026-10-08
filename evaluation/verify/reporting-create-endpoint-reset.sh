#!/usr/bin/env bash
# Execution RESET: ensure reporting_ep_task does NOT exist (verify FAILS on empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal\reporting\Entity\ReportingEndpoint::load("reporting_ep_task")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: reporting_ep_task absent"
