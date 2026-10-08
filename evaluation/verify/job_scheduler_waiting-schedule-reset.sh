#!/usr/bin/env bash
# Execution RESET: ensure NO 'jsw_worker' job exists so verify FAILS until the agent schedules it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("job_scheduler.manager")->removeAll("jsw_worker","jsw_worker_type");' >/dev/null 2>&1
echo "reset: 'jsw_worker' cleared"
