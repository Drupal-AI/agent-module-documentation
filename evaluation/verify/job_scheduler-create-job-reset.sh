#!/usr/bin/env bash
# Execution RESET: ensure NO 'js_task' job exists so verify FAILS until the agent schedules it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("job_scheduler.manager")->removeAll("js_task","js_task_type");' >/dev/null 2>&1
echo "reset: 'js_task' cleared (none scheduled)"
