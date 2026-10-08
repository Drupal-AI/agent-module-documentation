#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("job_scheduler.manager")->removeAll("js_remove","js_remove_type");' >/dev/null 2>&1
echo "cleanup: 'js_remove' removed"
