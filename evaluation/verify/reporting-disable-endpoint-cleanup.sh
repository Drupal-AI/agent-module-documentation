#!/usr/bin/env bash
# Execution CLEANUP: delete reporting_ep_toggle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($e = \Drupal\reporting\Entity\ReportingEndpoint::load("reporting_ep_toggle")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: reporting_ep_toggle removed"
