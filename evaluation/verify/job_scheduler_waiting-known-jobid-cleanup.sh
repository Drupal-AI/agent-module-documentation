#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("job_scheduler.manager")->removeAll("jsw_probe","jsw_probe_type");' >/dev/null 2>&1
echo "cleanup: 'jsw_probe' removed"
